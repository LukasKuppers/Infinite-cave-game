public class BinaryFormatter {
  
  int loadNum(String fileLocation) {
    byte saved[] = loadBytes(fileLocation);
    int output = 0;
    for(int i = 0; i < saved.length; i++) {
      output += saved[i];
    }
    return output;
  }
  
  void saveNum(int num, String fileLocation) {
    byte[] save = new byte[1000];
    int i = 0;
    while(num >= 100) {
      save[i] = byte(100);
      num -= 100;
      i++;
    }
    if(num > 0) {
      save[i] = byte(num);
    }
    //for(int j = 0; j < save.length; j++) { println("byte: "+(int)save[j]); }
    saveBytes(fileLocation, save);
  }
}
