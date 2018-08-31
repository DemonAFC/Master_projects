namespace uart_ex3
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.bConnect = new System.Windows.Forms.Button();
            this.bClose = new System.Windows.Forms.Button();
            this.bSend = new System.Windows.Forms.Button();
            this.tbTx = new System.Windows.Forms.TextBox();
            this.tbRX = new System.Windows.Forms.RichTextBox();
            this.cPort = new System.Windows.Forms.ComboBox();
            this.cBaudrate = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.tbEX = new System.Windows.Forms.RichTextBox();
            this.bImport = new System.Windows.Forms.Button();
            this.pBar = new System.Windows.Forms.ProgressBar();
            this.SuspendLayout();
            // 
            // bConnect
            // 
            this.bConnect.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.bConnect.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.bConnect.Location = new System.Drawing.Point(284, 275);
            this.bConnect.Name = "bConnect";
            this.bConnect.Size = new System.Drawing.Size(101, 24);
            this.bConnect.TabIndex = 0;
            this.bConnect.Text = "Connect";
            this.bConnect.UseVisualStyleBackColor = true;
            this.bConnect.Click += new System.EventHandler(this.bConnect_Click);
            // 
            // bClose
            // 
            this.bClose.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.bClose.Location = new System.Drawing.Point(419, 274);
            this.bClose.Name = "bClose";
            this.bClose.Size = new System.Drawing.Size(101, 24);
            this.bClose.TabIndex = 1;
            this.bClose.Text = "Close";
            this.bClose.UseVisualStyleBackColor = true;
            this.bClose.Click += new System.EventHandler(this.bClose_Click);
            // 
            // bSend
            // 
            this.bSend.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.bSend.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.bSend.Location = new System.Drawing.Point(419, 312);
            this.bSend.Name = "bSend";
            this.bSend.Size = new System.Drawing.Size(101, 24);
            this.bSend.TabIndex = 2;
            this.bSend.Text = "Send";
            this.bSend.UseVisualStyleBackColor = true;
            this.bSend.Click += new System.EventHandler(this.bSend_Click);
            this.bSend.KeyDown += new System.Windows.Forms.KeyEventHandler(this.tbTx_KeyDown);
            // 
            // tbTx
            // 
            this.tbTx.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbTx.Location = new System.Drawing.Point(16, 312);
            this.tbTx.Name = "tbTx";
            this.tbTx.Size = new System.Drawing.Size(234, 22);
            this.tbTx.TabIndex = 3;
            this.tbTx.KeyDown += new System.Windows.Forms.KeyEventHandler(this.tbTx_KeyDown);
            // 
            // tbRX
            // 
            this.tbRX.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbRX.Location = new System.Drawing.Point(12, 17);
            this.tbRX.Name = "tbRX";
            this.tbRX.Size = new System.Drawing.Size(238, 228);
            this.tbRX.TabIndex = 4;
            this.tbRX.Text = "";
            this.tbRX.TextChanged += new System.EventHandler(this.tbRX_TextChanged);
            // 
            // cPort
            // 
            this.cPort.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cPort.FormattingEnabled = true;
            this.cPort.Location = new System.Drawing.Point(15, 276);
            this.cPort.Name = "cPort";
            this.cPort.Size = new System.Drawing.Size(101, 24);
            this.cPort.TabIndex = 5;
            // 
            // cBaudrate
            // 
            this.cBaudrate.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cBaudrate.FormattingEnabled = true;
            this.cBaudrate.Items.AddRange(new object[] {
            "1200",
            "2400",
            "4800",
            "9600",
            "19200",
            "38400",
            "57600"});
            this.cBaudrate.Location = new System.Drawing.Point(149, 275);
            this.cBaudrate.Name = "cBaudrate";
            this.cBaudrate.Size = new System.Drawing.Size(101, 24);
            this.cBaudrate.TabIndex = 6;
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 249);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(34, 17);
            this.label1.TabIndex = 10;
            this.label1.Text = "Port";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(154, 248);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(66, 17);
            this.label2.TabIndex = 11;
            this.label2.Text = "Baudrate";
            // 
            // tbEX
            // 
            this.tbEX.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbEX.Location = new System.Drawing.Point(284, 17);
            this.tbEX.Name = "tbEX";
            this.tbEX.Size = new System.Drawing.Size(236, 228);
            this.tbEX.TabIndex = 12;
            this.tbEX.Text = "";
            this.tbEX.TextChanged += new System.EventHandler(this.tbEX_TextChanged);
            // 
            // bImport
            // 
            this.bImport.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.bImport.Location = new System.Drawing.Point(284, 312);
            this.bImport.Name = "bImport";
            this.bImport.Size = new System.Drawing.Size(101, 24);
            this.bImport.TabIndex = 13;
            this.bImport.Text = "Import";
            this.bImport.UseVisualStyleBackColor = true;
            this.bImport.Click += new System.EventHandler(this.bImport_Click);
            // 
            // pBar
            // 
            this.pBar.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pBar.Location = new System.Drawing.Point(284, 255);
            this.pBar.Name = "pBar";
            this.pBar.Size = new System.Drawing.Size(236, 10);
            this.pBar.TabIndex = 14;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(533, 352);
            this.Controls.Add(this.pBar);
            this.Controls.Add(this.bImport);
            this.Controls.Add(this.tbEX);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cBaudrate);
            this.Controls.Add(this.cPort);
            this.Controls.Add(this.tbRX);
            this.Controls.Add(this.tbTx);
            this.Controls.Add(this.bSend);
            this.Controls.Add(this.bClose);
            this.Controls.Add(this.bConnect);
            this.MaximumSize = new System.Drawing.Size(551, 1000);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "FFT Control";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button bConnect;
        private System.Windows.Forms.Button bClose;
        private System.Windows.Forms.Button bSend;
        private System.Windows.Forms.TextBox tbTx;
        private System.Windows.Forms.RichTextBox tbRX;
        private System.Windows.Forms.ComboBox cPort;
        private System.Windows.Forms.ComboBox cBaudrate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.RichTextBox tbEX;
        private System.Windows.Forms.Button bImport;
        private System.Windows.Forms.ProgressBar pBar;
    }
}

