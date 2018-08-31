using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO.Ports;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace uart_ex3
{
    public partial class Form1 : Form
    {
        static List<string> queue = new List<string>();
        public Form1()
        {
            InitializeComponent();
            bClose.Enabled = false;
            foreach(String s in System.IO.Ports.SerialPort.GetPortNames())
            {
                cPort.Items.Add(s);    
            }
        }

        public System.IO.Ports.SerialPort sport;    

        public void serialport_connect(String port, int baudrate, Parity parity, int databits, StopBits stopbits)
        {
            DateTime dt = DateTime.Now;
            String dtn = dt.ToShortTimeString();

            sport = new System.IO.Ports.SerialPort(port, baudrate, parity, databits, stopbits);
            try
            {
                sport.Open();
                bClose.Enabled = true;
                bConnect.Enabled = false;
                tbRX.AppendText("[" + dtn + "]" + " Connected.\n");

                sport.DataReceived += new SerialDataReceivedEventHandler(sport_Datareceived);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), " Error!");
            }
        }

        private void sport_Datareceived(object sender, SerialDataReceivedEventArgs e)
        {
            DateTime dt = DateTime.Now;
            String dtn = dt.ToShortTimeString();
            int n;
            bool IsExport_result = false;
            bool IsExport_input = false;
            var data = new List<byte>();
            var export_result = new List<byte>();
            var export_input = new List<byte>();
            do
            {
                n = sport.BytesToRead;
                byte[] buffer = new byte[n];
                try
                {
                    if (cmd_send == "5" && cmd_send_last != "1")
                    {
                        var size = sport.Read(buffer, 0, buffer.Length);
                        export_input.AddRange(buffer);
                    }
                    else if (cmd_send == "4" && cmd_send_last != "1")
                    {
                        var size = sport.Read(buffer, 0, buffer.Length);
                        export_result.AddRange(buffer);       
                    }
                    else
                    {
                        var size = sport.Read(buffer, 0, buffer.Length);
                        data.AddRange(buffer);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.ToString(), " Error!");
                }
            } while (n > 0);

            String exportdata_input = Encoding.ASCII.GetString(export_input.ToArray());
            String exportdata_result = Encoding.ASCII.GetString(export_result.ToArray());
            String recivedata = Encoding.ASCII.GetString(data.ToArray());
            tbEX.AppendText(exportdata_input);
            tbEX.AppendText(exportdata_result);
            tbRX.AppendText(recivedata);

            if (cmd_send == "5" && cmd_send_last != "1") // Export result FFT
            {
                StreamWriter File = new StreamWriter("exportdata_input.txt");
                File.Write(tbEX.Text);
                File.Close();
            }
            if (IsExport_input && n == 0)
            {
                tbRX.AppendText("[" + dtn + "]" + " exportdata_result done.\n");
            }

            if (cmd_send == "4" && cmd_send_last != "1") // Export result FFT
            {
                StreamWriter File = new StreamWriter("exportdata_result.txt");
                File.Write(tbEX.Text);
                File.Close();
       
            }
            if (IsExport_result)
            {
                tbRX.AppendText("[" + dtn + "]" + " exportdata_result done.\n");
            }
        }     

        private void bConnect_Click(object sender, EventArgs e)
        {
            String port = cPort.Text;
            int baudrate = Convert.ToInt32(cBaudrate.Text);
            if (port == "")
            {
                serialport_connect("COM5", 9600, System.IO.Ports.Parity.None, 8, System.IO.Ports.StopBits.One); // for debug
            }
            else
            {
                serialport_connect(port, Convert.ToInt32(cBaudrate.Text), System.IO.Ports.Parity.None, 8, System.IO.Ports.StopBits.One); // for run
            }


        }

        string[] Import = new string[1024];
        String cmd_send;
        String cmd_send_last;
        private void bSend_Click(object sender, EventArgs e)
        {
            DateTime dt = DateTime.Now;
            String dtn = dt.ToShortTimeString();
            cmd_send_last = cmd_send;
            cmd_send = tbTx.Text;
            
            pBar.Maximum = Import.Length;
            pBar.Step = 1;
            tbEX.Clear();

            sport.Write(cmd_send);
            tbRX.AppendText("\n---------------------------------------------\n\n");
            tbRX.AppendText("[" + dtn + "]" + " Sent: " + cmd_send + "\n\n");
                
            // Import new data on board
            if (cmd_send == "3" && IsImport)
            {     
                for (int i = 0; i < Import.Length; i++)
                {
                    sport.Write(Import[i]);
                    System.Threading.Thread.Sleep(10); // Debug transimiting error
                    sport.Write("\n");
                    System.Threading.Thread.Sleep(5);
                    pBar.PerformStep();
                }
                sport.Write("\r");
                tbRX.AppendText("[" + dtn + "]" + " Import done.\n");
            }
        }

        private void bClose_Click(object sender, EventArgs e)
        {
            DateTime dt = DateTime.Now;
            String dtn = dt.ToShortTimeString();

            if (sport.IsOpen)
            {
                sport.Close();
                bClose.Enabled = false;
                bConnect.Enabled = true;
                tbRX.AppendText("[" + dtn + "]" + " Disconnected.\n");
            }
        }

        private void tbTx_KeyDown(object sender, KeyEventArgs e)
        {
                if (e.KeyCode == Keys.Return)
                {
                    bSend.PerformClick();
                    // these last two lines will stop the beep sound
                    e.SuppressKeyPress = true;
                    e.Handled = true;
                }
            tbTx.Clear();
        }

        private void tbRX_TextChanged(object sender, EventArgs e)
        {
            // set the current caret position to the end
            tbRX.SelectionStart = tbRX.Text.Length;
            // scroll it automatically
            tbRX.ScrollToCaret();
        }

        private void tbEX_TextChanged(object sender, EventArgs e)
        {
            // set the current caret position to the end
            tbEX.SelectionStart = tbEX.Text.Length;
            // scroll it automatically
            tbEX.ScrollToCaret();
        }

        bool IsImport = false;
        private void bImport_Click(object sender, EventArgs e)
        {
            pBar.Value = 0; // reset value of progress bar
            tbEX.Clear(); // clear the export window
            try
            {
                using (OpenFileDialog ofd = new OpenFileDialog() { Filter = "Text Documents|*.txt", Multiselect = false, ValidateNames = true })
                {
                    if(ofd.ShowDialog() == DialogResult.OK)
                    {
                        Import = System.IO.File.ReadAllLines(ofd.FileName);
                        for(int i=0; i< Import.Length; i++)
                        {
                            tbEX.AppendText(Import[i]+"\n");
                        }
                    }
                }
            }catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), " Error!");
            }
            IsImport = true;
        }
    }
}
