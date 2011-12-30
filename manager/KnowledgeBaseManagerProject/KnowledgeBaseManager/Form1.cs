using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Collections;
namespace Iskanje_objektov
{
    public partial class FormKBM1 : Form
    {

        private List<string> listOfPaths;
        private List<string> listOfNames;
        private string loadedAttribute;

        public FormKBM1()
        {
            InitializeComponent();
            listOfPaths = new List<string>();
            listOfNames = new List<string>();
        }

        //loading the objects
        private void button2_Click(object sender, EventArgs e)
        {

            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Multiselect = true;
            DialogResult pot = ofd.ShowDialog();
            if (pot == DialogResult.OK)
            {
                listOfPaths.Clear();
                listOfNames.Clear();
                for (int i = 0; i < ofd.FileNames.Length; i++)
                {
                    Uri uri = new Uri(ofd.FileNames[i]);
                    string filename = Path.GetFileName(uri.LocalPath);
                    listOfPaths.Add(ofd.FileNames[i]);
                    listBox1.Items.Add(Path.GetFileName(uri.LocalPath));                 
                }
                StatusLabel.Text = ofd.FileNames.Length + " objects loaded succesfully";
            
            }
            else
                MessageBox.Show("File path is invalid");

        }

        // loading the attribute
        private void button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Multiselect = false;
            DialogResult pot = ofd.ShowDialog();
            if (pot == DialogResult.OK)
            {
                Uri uri = new Uri(ofd.FileName);
                string filename = Path.GetFileName(uri.LocalPath);
                loadedAttribute = filename.Substring(0, filename.IndexOf('.'));
               // MessageBox.Show(loadedAttribute);
                textBox2.Text = ofd.FileName;
                StringBuilder sb = new StringBuilder();
                StreamReader sr = new StreamReader(ofd.FileName);
                textBox1.Text = sr.ReadToEnd();
            }
            else
                MessageBox.Show("File path is invalid");

        }

        //set the attribute to the object
        private void button3_Click(object sender, EventArgs e)
        {
            setAttribute(loadedAttribute);
        }

        //function sets the attribute to the object
        private void setAttribute(string attributeName)
        {
            bool setIt;
            
            for(int i = 0; i<listOfPaths.Count;i++)
            {

                if (listBox1.SelectedIndices.Contains(i))
                {

                    string currentPath = listOfPaths[i];
                    Uri uri = new Uri(listOfPaths[i]);
                    string nameOfCurrentObject = Path.GetFileNameWithoutExtension(uri.LocalPath);


                    StreamReader sr = new StreamReader(currentPath);
                    string line;
                    setIt = true;
                    //MessageBox.Show(currentPath);
                    while ((line = sr.ReadLine()) != null)
                    {
                        if (line != "")
                        {
                            line = line.Substring(0, line.IndexOf('('));

                            if (line == loadedAttribute)
                                setIt = false;
                        }
                    }
                    sr.Close();

                    if (setIt)
                    {
                        StreamWriter sw = new StreamWriter(currentPath, true);
                        sw.WriteLine(loadedAttribute + "(" + nameOfCurrentObject + ").");
                        sw.Close();
                        StatusLabel.Text = "Attribute set succesfully";
                    }
                }
                
            }
        }

        // removing attributes from objects 
        private void button4_Click(object sender, EventArgs e)
        {

            for (int i = 0; i < listOfPaths.Count; i++)
            {

                if (listBox1.SelectedIndices.Contains(i))
                {

                    string currentPath = listOfPaths[i];
                    Uri uri = new Uri(listOfPaths[i]);
                    string nameOfCurrentObject = Path.GetFileNameWithoutExtension(uri.LocalPath);

                    StreamReader sr = new StreamReader(currentPath);
                    string line;
                    string text="";
                  //  MessageBox.Show(currentPath);

                    while ((line = sr.ReadLine()) != null)
                    {
                        if (line != "")
                        {
                            string DeleteLine = line.Substring(0, line.IndexOf('('));

                            if (DeleteLine != loadedAttribute)
                            {
                                text += line + Environment.NewLine;
                            }
                        }
                    }
                    sr.Close();

                    StreamWriter sw = new StreamWriter(currentPath);
                    sw.Write(text);
                  //  sw.WriteLine("");
                    sw.Close();

                    StatusLabel.Text = "Attribute removed succesfully";

                }

            }
        }
        
    }
}
