  import controlP5.*;
import java.util.*;
ControlP5 cp5;


void settings() {
  size(displayWidth,displayHeight);
}

//settings
int menuType = 0; 
/*
 0 = loading screen
 1 = menu
 2 = play
 3 = settings
 4 = Sprache
 5 = help
 */
int startScreenLength = 1500;                //in ms
int redraw = 0;                              //variable for redrawing if options were changed
int defaultLanguage = 1;                     //Language, 1 = German, 0 = English
//int mode = 0;                              //0 = Alkane, 1 = Alkene, 2 = Alkine, 3 = Aldehyde, 4 = Carboxylic acid, 5 = Alcohol
int alpha = 35;
float dx = cos(radians(alpha)) * 60;         // dx for angle; "-" for left bound; radians(36)
float dy = sin(radians(alpha)) * 30;         // dy/2 for angle
float methanHshiftx = sin(radians(60));      
float methanHshifty = cos(radians(60));
String name;                                 //names of molecules
//Part of the false name generator
String false1;                               //first false name
int C1=1;                                  
int false1positionAlkene;
int false1positionAlkine;
int false1positionAlcohol;
String false2;
int C2=1;                                      
int mode2;
int false2positionAlkene;
int false2positionAlkine;
int false2positionAlcohol;
String false3;
int C3=1;
int mode3;
int false3positionAlkene;
int false3positionAlkine;
int false3positionAlcohol;

//languages
String ZurueckL;
String ZuruecksetzenL;
String SpielenL;
String OptionenL;
String SpracheL;
String HilfeL;
String KettenlaengeL;
String AlkaneL;
String AlkeneL;
String AlkineL;
String AldehydeL;
String CarbonsaeurenL;
String AlkoholeL;
String RichtigL;
String FalschL;
String suffixAlkaneL;
String suffixAlkeneL; 
String suffixAlkineL;
String suffixAldehydeL;
String suffixAcidL;
String suffixAlcoholL;
String helpTextL;


//Alkane values (general values)
int n = 0; //do not change
int C = 1; //number of C atoms                //Old input method
StringList nameAlkane;                        //Meth, Eth, Prop etc


//Alkene values
PVector v1, vy;                               //vectorial transformation of second binding
int positionAlkene = 1;                       //position of binding (Prop-2-en; Prop-1-en), max input = C/2 even, = (C-1)/2 odd
//suffix

//Alkine values
PVector yup;
PVector ydown;
PVector VAlkine;
int positionAlkine = 3;

//Aldehyde values
PVector VAldehydeO;
PVector VAldehydeBV;

int positionAldehyde = C - 1;

//Carboxylic Acid Values
PVector VAcidO;

int positionCarboxylicGroup = C - 1;

//Alcohol Values
PVector VAlcoholO;
int positionAlcohol;


//buttons
color t1 = color(121, 149, 255);
color f1 = color(121, 149, 255);
color f2 = color(121, 149, 255);
color f3 = color(121, 149, 255);
color t1to = t1;
color t1from = t1;
color f1to = f1;
color f1from = f1;
color f2to = f2;
color f2from = f2;
color f3to = f3;
color f3from = f3;

//font

//random pos
IntList randomPos1;
{
  randomPos1 = new IntList();
  randomPos1.append(0);
  randomPos1.append(1);
  randomPos1.append(2);
  randomPos1.append(3);
}
//random mode
int mode = 0;
int[] modeRandom={0};
boolean Alkane = true;
boolean Alkene = false;
boolean Alkine = false;
boolean Aldehyde = false;
boolean Acid = false;
boolean Alkohole = false;
int chainLength = 5;

int trueCounter = 0;
int falseCounter = 0;
//*-------------------------------------------------------------------------------------------------------------------------------------------------------------*
void setup() {
  smooth();
  orientation(PORTRAIT);
  //load and save variables (future feature)
  //Vectors for Generator go here
  v1 = new PVector(sin(radians(alpha)) * 8, sin(radians(alpha)) * 8);
  vy = new PVector(sin(radians(alpha)) * 8, -cos(radians(alpha)) * 8);
  yup = new PVector(0, -4 * dy); 
  ydown = new PVector(0, 4 * dy);
  VAlkine = new PVector(sin(radians(alpha)) * 8, cos(radians(alpha)) * 8);
  VAldehydeO = new PVector(sin(radians(alpha)) * 4, sin(radians(alpha)) * 4 - 2); //O-Atom
  VAldehydeBV = new PVector(cos(radians(alpha)) * 5, sin(radians(alpha)) * 5); //lines
  VAcidO = new PVector(cos(radians(alpha)) * 4, sin(radians(alpha)) * 4 - 2);
  
  //Controllers go here
  cp5 = new ControlP5(this);
  cp5.addButton("playButton")
    .hide()
    ;
  cp5.addButton("settingsButton")
    .hide()
    ;
  cp5.addButton("languageButton")
    .hide()
    ;
  cp5.addButton("helpButton")
    .hide()
    ;
  cp5.addRadioButton("languagesList")
    .hide()
    .addItem("English", 1)
    .addItem("Deutsch", 2)
    .setItemsPerRow(5)
    .activate(defaultLanguage)
    .setNoneSelectedAllowed(false)
    ;
  cp5.addSlider("chainLength")
    .hide()
    .setValue(5);
  ;
  cp5.addToggle("toggleAlkane")
    .hide()
        .setValue(true)
        .setMode(ControlP5.SWITCH)
    ;
  cp5.addToggle("toggleAlkene")
    .hide()
        .setValue(false)
        .setMode(ControlP5.SWITCH)
    ;
  cp5.addToggle("toggleAlkine")
    .hide()
        .setValue(false)
        .setMode(ControlP5.SWITCH)
    ;
  cp5.addToggle("toggleAldehyde")
    .hide()
        .setValue(false)
        .setMode(ControlP5.SWITCH)
    ;
  cp5.addToggle("toggleAcid")
    .hide()
        .setValue(false)
        .setMode(ControlP5.SWITCH)
    ;
  cp5.addToggle("toggleAlkohole")
    .hide()
        .setValue(false)
        .setMode(ControlP5.SWITCH)
    ;
  cp5.addButton("backButton")
    .hide()
    ;
  cp5.addButton("resetButton")
    .hide()
    ;
  cp5.addButton("trueButton")
    .hide()
    ;
  cp5.addButton("falseButton1")
    .hide()
    ;
  cp5.addButton("falseButton2")  
    .hide()
    ;
  cp5.addButton("falseButton3")
    .hide()
    ;
    int headHeight = height/15 + 10; //double height of backButton !
    int posx,posy;
    posx = width/10;
    posy = height/10;
  cp5.addTextarea("helpTextArea")
    .hide()
    .setLineHeight(height/60+height/360)
    .setColor(color(255))
    .setColorBackground(color(255,100))
    .setColorForeground(color(255,100))
    .setFont(createFont("arial", height/60))
    .setPosition(posx,posy+headHeight)
    .setSize(width-width/5,height-height/5-headHeight)
    ;
}
//*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
//####################################################################################################################################################################################################################################################
//####################################################################################################################################################################################################################################################
//*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
void draw() {
  strokeWeight(1);
  //Controllers
  Button playButton = (Button) cp5.getController("playButton");                                 //play button
  Button settingsButton = (Button) cp5.getController("settingsButton");                         //settings
  Button languageButton = (Button) cp5.getController("languageButton");                         //languages
  Button helpButton = (Button) cp5.getController("helpButton");                                 //help
  RadioButton languagesList = cp5.get(RadioButton.class, "languagesList");                      //default method was not possible ...
  Slider chainLengthSlider = (Slider) cp5.getController("chainLength");
  Toggle toggleAlkane = (Toggle) cp5.getController("toggleAlkane");
  Toggle toggleAlkene = (Toggle) cp5.getController("toggleAlkene");
  Toggle toggleAlkine = (Toggle) cp5.getController("toggleAlkine");
  Toggle toggleAldehyde = (Toggle) cp5.getController("toggleAldehyde");
  Toggle toggleAcid = (Toggle) cp5.getController("toggleAcid");
  Toggle toggleAlkohole = (Toggle) cp5.getController("toggleAlkohole");
  Button backButton = (Button) cp5.getController("backButton");
  Button resetButton = (Button) cp5.getController("resetButton");                               //reset Button
  Button trueButton = (Button) cp5.getController("trueButton");                                 //true Button
  Button falseButton1 = (Button) cp5.getController("falseButton1");                             //first false Button
  Button falseButton2 = (Button) cp5.getController("falseButton2");                             //first false Button
  Button falseButton3 = (Button) cp5.getController("falseButton3");                             //first false Button
  Textarea helpTextArea = cp5.get(Textarea.class, "helpTextArea");
//####################################################################################################################################################################################################################################################
  //Languages
  if (defaultLanguage == 0) {
    ZurueckL = "Back";
    ZuruecksetzenL = "Reset";
    SpielenL = "Play";
    OptionenL = "Options";
    SpracheL = "Language";
    HilfeL = "Help";
    KettenlaengeL = "Chain length (maximum)";
    AlkaneL = "Alkane";
    AlkeneL = "Alkene";
    AlkineL = "Alkine";
    AldehydeL = "Aldehyde";
    CarbonsaeurenL = "Carboxylic Acids";
    AlkoholeL = "Alcohols";
    RichtigL = "Correct: ";
    FalschL = "Wrong: ";
    suffixAlkaneL = "ane";
    suffixAlkeneL = "ene"; 
    suffixAlkineL = "yne";
    suffixAldehydeL = "anal";
    suffixAcidL = "anoic acid";
    suffixAlcoholL = "ol";
    helpTextL =   "Cheatsheet: \n\n"
                + "List of prefixes: \n"
                + "1 Meth \n2 Eth \n3 Prop\n4 But\n5 Pent\n6 Hex\n7 Hept\n8 Oct\n9 Non\n10 Dec\n\n"
                + "List of straight-chain suffixes:\n"
                + "Alkane:\t -an\nAlkene:\t -ene\nAlkyne:\t -yne\n\n"
                + "List of functional group suffixes:\n"
                + "Alcohols: -ol\nAldehydes: -al\nCarboxylic acids: -oic acid\n\n\n"
                + "How to Play:\n"
                + "If needed, press the \"Options\" button in the main menu and customize your settings as you see fit.\nIf you're done, press the \"Play\"button to start the game.\nPress the button with the name you believe fits the generated structure formula.\n"
                + "If you are correct, you will advance. If you are wrong, the button will turn red.\nThe amount of Answers you got correct or wrong will be in the score section in the upper part of your display.\n"
                + "To reset your score, press the \"Reset\" button in the upper right corner."
                ;
  }
  if (defaultLanguage == 1) {
    ZurueckL = "Zurück";
    ZuruecksetzenL = "Zurücksetzen";
    SpielenL = "Spielen";
    OptionenL = "Optionen";
    SpracheL = "Sprache";
    HilfeL = "Hilfe";
    KettenlaengeL = "Kettenlänge (maximal)";
    AlkaneL = "Alkane";
    AlkeneL = "Alkene";
    AlkineL = "Alkine";
    AldehydeL = "Aldehyde";
    CarbonsaeurenL = "Carbonsäuren";
    AlkoholeL = "Alkohole";
    RichtigL = "Richtig: ";
    FalschL = "Falsch: ";
    suffixAlkaneL = "an";
    suffixAlkeneL = "en"; 
    suffixAlkineL = "in";
    suffixAldehydeL = "anal";
    suffixAcidL = "ansäure";
    suffixAlcoholL = "ol";
    helpTextL =   "Spickzettel: \n\n"
                + "Liste der Zahlwörter: \n"
                + "1 Meth \n2 Eth \n3 Prop\n4 But\n5 Pent\n6 Hex\n7 Hept\n8 Okt\n9 Non\n10 Dec\n\n"
                + "Liste der Suffixe der linearen Ketten:\n"
                + "Alkane:\t -an\nAlkene:\t -en\nAlkine:\t -in\n\n"
                + "Liste der Suffixe der funktionellen Gruppen:\n"
                + "Alkohole: -ol\nAldehyde: -al\nCarbonsäuren: -säure\n\n\n"
                + "Wie man spielt:\n"
                + "Wenn nötig, drücken Sie auf die Schaltfläche \"Optionen\" und passen Sie an.\nDrücken Sie die Schaltfläche \"Spielen\" um das Spiel zu starten.\nDrücken Sie auf die Schaltfläche, welche der generierten Strukturformel entspricht.\n"
                + "Sollten Sie richtig liegen, kommen Sie weiter. Sollten Sie falsch liegen, so wird die Schaltfläche rot.\nIhren Punktestand sehen Sie im Oberen Bereich Ihres Bildschirms.\n"
                + "Um den Punktestand zurückzusetzen, drücken sie auf \"Zurücksetzen\" in der oberen rechten Ecke."
                ;
  }
//####################################################################################################################################################################################################################################################
  //BackButton 
  if ((menuType == 2) || (menuType == 3)|| (menuType == 4)|| (menuType == 5)) { //should always show except main menu
    int backx, backy;
    int buttonWidth, buttonHeight;
    backx = 5;
    backy = 5;
    buttonWidth = width/5;
    buttonHeight = height/15;
    int CaptionLabelHeight = buttonHeight/2;
    PFont pfont = createFont("Arial", CaptionLabelHeight, true);                                                   // for the font
    ControlFont font = new ControlFont(pfont, 241);
    backButton.setCaptionLabel(ZurueckL);
    backButton.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    backButton.show();
    backButton.setSize(buttonWidth, buttonHeight);
    backButton.setPosition(backx, backy);
  } 
//####################################################################################################################################################################################################################################################
  //ResetButton 
  if (menuType == 2) {
    int resetx, resety;
    int buttonWidth, buttonHeight;
    
    resety = 5;
    buttonHeight = height/15;
    textSize(buttonHeight/2);
    buttonWidth = (int)textWidth("Zurücksetzen")+20;
    int CaptionLabelHeight = buttonHeight/2;
    resetx = width-buttonWidth-5;
    PFont pfont = createFont("Arial", CaptionLabelHeight, true);                                                   // for the font
    ControlFont font = new ControlFont(pfont, 241);
    resetButton.setCaptionLabel(ZuruecksetzenL);
    resetButton.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    resetButton.show();
    resetButton.setSize(buttonWidth, buttonHeight);
    resetButton.setPosition(resetx, resety);
    if((trueCounter == 0) && (falseCounter == 0)){          //locks the button if nothing has been done 
      resetButton.hide();
    }
  }  
//####################################################################################################################################################################################################################################################
  //Loading Screen
  if (menuType == 0) {
    background(230);
    PImage img;
    img = loadImage("icon-192.png");
    image (img, width/2-192/2,height/2-192/2);
    textSize(width/10);
    textAlign(CENTER, CENTER);
    text("Nomenklatur Basic", width/2,height/4);
    chainLength = 5;
    if (frameCount >= (int)startScreenLength*60/1000) {
      menuType += 1;
    }
    C = round(random(1, chainLength));
    int randomModeRandom = round(random(0, modeRandom.length-1));
    mode = modeRandom[randomModeRandom];
    mode2 = modeRandom[randomModeRandom];
    mode3 = modeRandom[randomModeRandom];
  }
//####################################################################################################################################################################################################################################################
  //Main Menu
  if (menuType == 1) {
    background(120);
    trueButton.hide();
    falseButton1.hide();
    falseButton2.hide();
    falseButton3.hide();
    backButton.hide();
    resetButton.hide();
    languagesList.hide();

    //dimensions of the Buttons
    int playx, playy, settingsx, settingsy, languagex, languagey, helpx, helpy;
    int buttonWidth = width - 2*width/10;
    int buttonHeight = height/10;
    playx = width/10;
    playy = height/10;
    settingsx = playx;
    settingsy = playy + height/20 + height/10;
    languagex = playx;
    languagey = settingsy + height/20 + height/10;
    helpx = playx;
    helpy = languagey + height/20 + height/10;
    int CaptionLabelHeight = buttonHeight/2;
    PFont pfont = createFont("Arial", CaptionLabelHeight, true);                                                   // for the font
    ControlFont font = new ControlFont(pfont, 241);
    //buttons go here
    chainLengthSlider.hide();
    toggleAlkane.hide();
    toggleAlkene.hide();
    toggleAlkine.hide();
    toggleAldehyde.hide();
    toggleAcid.hide();
    toggleAlkohole.hide();
    playButton.show();
    playButton.setCaptionLabel(SpielenL);
    playButton.setSize(buttonWidth, buttonHeight);
    playButton.setPosition(playx, playy);
    playButton.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    settingsButton.show();
    settingsButton.setCaptionLabel(OptionenL);
    settingsButton.setSize(buttonWidth, buttonHeight);
    settingsButton.setPosition(settingsx, settingsy);
    settingsButton.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    languageButton.show();
    languageButton.setCaptionLabel(SpracheL);
    languageButton.setSize(buttonWidth, buttonHeight);
    languageButton.setPosition(languagex, languagey);
    languageButton.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    helpButton.show();
    helpButton.setCaptionLabel(HilfeL);
    helpButton.setSize(buttonWidth, buttonHeight);
    helpButton.setPosition(helpx, helpy);
    helpButton.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    helpTextArea.hide();

    fill(160);
    textAlign(CENTER, BOTTOM);
    textSize(height/40);
    text("by Patrick Eppensteiner", width/2, height-height/20);
  }
//####################################################################################################################################################################################################################################################
  //Help
  if (menuType == 5) {
    background(120);
    playButton.hide();
    settingsButton.hide();
    languageButton.hide();
    helpButton.hide();
    backButton.show();
    int headWidth = width;
    int headHeight = height/15 + 10; //double height of backButton !
    fill(0);
    rect(0, 0, headWidth, headHeight);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(height/40);
    text(HilfeL, headWidth/2, headHeight/2);
    helpTextArea.show();    
    helpTextArea.setText(helpTextL);
  }
  //####################################################################################################################################################################################################################################################
  if (menuType == 4) {
    background(120);
    playButton.hide();
    settingsButton.hide();
    languageButton.hide();
    helpButton.hide();
    backButton.show();
    int headWidth = width;
    int headHeight = height/15 + 10; //double height of backButton !
    fill(0);
    rect(0, 0, headWidth, headHeight);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(height/40);
    text(SpracheL, headWidth/2, headHeight/2);


    int settingsBackgroundWidth, settingsBackgroundHeight;
    settingsBackgroundWidth = width - 2*width/10;
    settingsBackgroundHeight = height/10;
    int posx, posy;
    posx = width/10;
    posy = height/10;
    textAlign(CENTER, CENTER);
    fill(255);
    int CaptionLabelHeight = settingsBackgroundHeight/2;
    PFont pfont = createFont("Arial", CaptionLabelHeight, true);                                                   // for the font
    ControlFont font = new ControlFont(pfont, CaptionLabelHeight);
    languagesList.show();
    languagesList.setPosition(posx, posy);
    languagesList.setSize(settingsBackgroundWidth/2, settingsBackgroundHeight);
    for (Toggle t : languagesList.getItems()) {
      t.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER).setPaddingX(0);
      t.getCaptionLabel().setSize(CaptionLabelHeight).setFont(font).toUpperCase(false);
    }
  }
  //####################################################################################################################################################################################################################################################
  if (menuType == 3) {
    background(120);
    playButton.hide();
    settingsButton.hide();
    languageButton.hide();
    helpButton.hide();
    backButton.show();
    int headWidth = width;
    int headHeight = height/15 + 10; //double height of backButton !
    rect(0, 0, headWidth, headHeight);
    textAlign(CENTER, CENTER);
    fill(255);
    text(OptionenL, headWidth/2, headHeight/2);
    int settingsBackgroundWidth, settingsBackgroundHeight;
    settingsBackgroundWidth = width - 2*width/10;
    settingsBackgroundHeight = height/10;
    int posx, posy;
    posx = width/10;
    posy = height/10;
    int translatey = height/10;
    int textx, texty;
    textx = width/10 +settingsBackgroundHeight/4;
    texty = height/10 +settingsBackgroundHeight/2;
    int togglex, toggley, toggleWidth, toggleHeight;
    toggleWidth = settingsBackgroundHeight;
    toggleHeight = settingsBackgroundHeight/2;
    togglex = posx + settingsBackgroundWidth - toggleWidth - settingsBackgroundHeight/4;
    toggley = height/10 +settingsBackgroundHeight/4;
    int chainLengthWidth = settingsBackgroundWidth-round(4*textWidth("10"));
    int textx2 = posx+settingsBackgroundWidth-settingsBackgroundHeight/2;
    pushMatrix();                                                                           //Chain Length
    translate(0, 0);
    fill(255);
    rect(posx, posy, settingsBackgroundWidth, settingsBackgroundHeight);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(settingsBackgroundHeight/4);
    text(KettenlaengeL, textx, texty);
    chainLengthSlider.show();
    chainLengthSlider.setSliderMode(Slider.FLEXIBLE);
    chainLengthSlider.bringToFront();
    chainLengthSlider.setWidth(chainLengthWidth);
    chainLengthSlider.setPosition(width/10+2*textWidth("10"), posy+settingsBackgroundHeight+(translatey+height/10)/3-settingsBackgroundHeight/2);
    chainLengthSlider.setRange(5, 10);
    chainLengthSlider.setSize(chainLengthWidth, settingsBackgroundHeight/2);
    chainLengthSlider.setNumberOfTickMarks(6);
    chainLengthSlider.setCaptionLabel("");
    chainLengthSlider.getValueLabel().hide();
    chainLengthSlider.setColorTickMark(0);
    int chainLengthValue;
    textAlign(RIGHT, CENTER);
    if (chainLengthSlider.getValue() <= 10 && chainLengthSlider.getValue()>=5) {
      chainLengthValue = round(chainLengthSlider.getValue());
      text(chainLengthValue, textx2, texty);
    }
    if (chainLengthSlider.getValue() < 5) {
      text("5", textx2, texty);
    }
    if (chainLengthSlider.getValue() > 10) {
      text("10", textx2, texty);
    }
    popMatrix();

    pushMatrix(); 
    
    //toggle Alkane
    textAlign(LEFT, CENTER);
    translate(0, translatey+height/10);
    fill(255);
    rect(posx, posy, settingsBackgroundWidth, settingsBackgroundHeight);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(settingsBackgroundHeight/4);
    toggleAlkane.unlock();
    text(AlkaneL, textx, texty);
    if(toggleAlkene.getValue() == 0 && toggleAlkine.getValue() == 0 && toggleAldehyde.getValue() == 0 && toggleAcid.getValue() == 0 && toggleAlkohole.getValue() == 0){ //Alkane should be enabled by default if nothing else is enabled
      toggleAlkane.setValue(true);
      toggleAlkane.lock();
    }
    toggleAlkane.show();
    toggleAlkane.setPosition(togglex, toggley+translatey+height/10);
    toggleAlkane.setSize(toggleWidth, toggleHeight);
    toggleAlkane.setCaptionLabel("");
    
    
    //toggle Alkene
    textAlign(LEFT, CENTER);
    translate(0, translatey);
    fill(255);
    rect(posx, posy, settingsBackgroundWidth, settingsBackgroundHeight);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(settingsBackgroundHeight/4);
    text(AlkeneL, textx, texty);
    toggleAlkene.show();
    toggleAlkene.setPosition(togglex, toggley+2*translatey+height/10);
    toggleAlkene.setSize(toggleWidth, toggleHeight);
    toggleAlkene.setCaptionLabel("");


    //toggle Alkine
    translate(0, translatey);
    fill(255);
    rect(posx, posy, settingsBackgroundWidth, settingsBackgroundHeight);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(settingsBackgroundHeight/4);
    text(AlkineL, textx, texty); 
    toggleAlkine.show();
    toggleAlkine.setPosition(togglex, toggley+3*translatey+height/10);
    toggleAlkine.setSize(toggleWidth, toggleHeight);
    toggleAlkine.setCaptionLabel("");


    //toggle Aldehyde
    translate(0, translatey);
    fill(255);
    rect(posx, posy, settingsBackgroundWidth, settingsBackgroundHeight);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(settingsBackgroundHeight/4);
    text(AldehydeL, textx, texty);
    toggleAldehyde.show();
    toggleAldehyde.setPosition(togglex, toggley+4*translatey+height/10);
    toggleAldehyde.setSize(toggleWidth, toggleHeight);
    toggleAldehyde.setCaptionLabel("");


    //toggle Acid
    translate(0, translatey);
    fill(255);
    rect(posx, posy, settingsBackgroundWidth, settingsBackgroundHeight);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(settingsBackgroundHeight/4);
    text(CarbonsaeurenL, textx, texty);
    toggleAcid.show();
    toggleAcid.setPosition(togglex, toggley+5*translatey+height/10);
    toggleAcid.setSize(toggleWidth, toggleHeight);
    toggleAcid.setCaptionLabel("");

    //toggle Alkohole
    translate(0, translatey);
    fill(255);
    rect(posx, posy, settingsBackgroundWidth, settingsBackgroundHeight);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(settingsBackgroundHeight/4);
    text(AlkoholeL, textx, texty);
    toggleAlkohole.show();
    toggleAlkohole.setPosition(togglex, toggley+6*translatey+height/10);
    toggleAlkohole.setSize(toggleWidth, toggleHeight);
    toggleAlkohole.setCaptionLabel("");

    popMatrix();
  }
  //####################################################################################################################################################################################################################################################
  if (menuType == 2) {
    background(220);
    int headWidth = width;
    int headHeight = height/15 + 10; //double height of backButton !
    fill(160);
    rect(0, 0, headWidth, headHeight);
    fill(#00FF46);
    rect(5, headHeight+5, headWidth-10, headHeight/2, 6, 6, 6, 6);
    fill(#FF0033);
    rect(5, headHeight+5+headHeight/2+5, headWidth-10, headHeight/2, 6, 6, 6, 6);
    //Generator goes here
    int positionAldehyde = C - 1;
    stroke(0);
    strokeWeight(3);
    strokeCap(ROUND);
    pushMatrix();
    fill(0);
    textSize(headHeight/4);
    textAlign(LEFT, CENTER);
    text(RichtigL, width/10, headHeight+5+headHeight/4);
    text(FalschL, width/10, headHeight+5+headHeight/2+5+headHeight/4);
    textAlign(RIGHT, CENTER);
    text(trueCounter, width/2, headHeight+5+headHeight/4);
    text(falseCounter, width/2, headHeight+5+headHeight/2+5+headHeight/4);
    popMatrix();


    //Nomenklatur (names) go here
    typeName(mode, C);
    //  text(name, width / 2, 500);

    //      println(name);


    //randompos Generator
    int buttonHeight = height/10-2;
    int buttonWidth = width/2-6;
    int CaptionLabelHeight = buttonHeight/3; //make denominator bigger if experiencing text out of box.
    int posx1 = 0+5;
    int posy1 = height - 2*buttonHeight-5;
    int posx2 = width/2+2;
    int posy2 = posy1;
    int posx3 = posx1;
    int posy3 = height-buttonHeight+2-5;
    int posx4 = posx2;
    int posy4 = posy3;
    int [][] randomPos = {{posx1, posy1}, {posx2, posy2}, {posx3, posy3}, {posx4, posy4}};

    if (f1 != color(191, 87, 87)) {        //was used for lerpcolor, not sure if needed now
      f1 = color(f1to);
    }

    if (f2 != color(191, 87, 87)) {
      f2 = color(f2to);
    }
    if (f3 != color(191, 87, 87)) {
      f3 = color(f3to);
    }

    //  int[] posb1 = new int[posx1, posy1]+
    //font
    PFont pfont = createFont("Arial", CaptionLabelHeight, true); // use true/false for smooth/no-smooth
    ControlFont font = new ControlFont(pfont, 241);
    //buttons go here
    playButton.hide();
    settingsButton.hide();
    languageButton.hide();
    helpButton.hide();
    trueButton.setCaptionLabel(name);                                                                //sets appropriate name
    trueButton.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    trueButton.setSize(buttonWidth, buttonHeight);                                             
    trueButton.setPosition(randomPos[randomPos1.get(0)][0], randomPos[randomPos1.get(0)][1]);        //random Position
    trueButton.setColorBackground(t1);
    trueButton.show();

    falseButton1.setCaptionLabel(false1);                                                          
    falseButton1.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    falseButton1.setSize(buttonWidth, buttonHeight);                                           
    falseButton1.setPosition(randomPos[randomPos1.get(1)][0], randomPos[randomPos1.get(1)][1]);
    falseButton1.setColorBackground(f1);
    falseButton1.show();


    falseButton2.setCaptionLabel(false2);                                                      
    falseButton2.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    falseButton2.setSize(buttonWidth, buttonHeight);                                           
    falseButton2.setPosition(randomPos[randomPos1.get(2)][0], randomPos[randomPos1.get(2)][1]);
    falseButton2.setColorBackground(f2);
    falseButton2.show();


    falseButton3.setCaptionLabel(false3);                                                      
    falseButton3.getCaptionLabel().setFont(font).setSize(CaptionLabelHeight).toUpperCase(false);
    falseButton3.setSize(buttonWidth, buttonHeight);                                           
    falseButton3.setPosition(randomPos[randomPos1.get(3)][0], randomPos[randomPos1.get(3)][1]);
    falseButton3.setColorBackground(f3);
    falseButton3.show();
    
    

    pushMatrix();
    float changeScaleDisplayWidth1 = width/12/dx;
    translate(width/2-((C-1)*cos(radians(alpha))*60)/2*changeScaleDisplayWidth1, height/2); //scale also scales the position, this translate is used to shift it back
    scale(changeScaleDisplayWidth1,changeScaleDisplayWidth1);                               //scale to fit in any screen resolution 
    drawAlkane(n, 0, dy, dx, -dy);                                               //function Hexane(). n: always 0 (number of C (CHANGE THIS FOR OTHER!), starting value x,y, (differences between x), y2 (interchanged with y1 each consecutive))
    drawAlkene(n, positionAlkene, 0, dy, dx, -dy);
    drawAlkine(n, positionAlkine, 0, dy, dx, -dy);
    drawAlcohol(n, positionAlcohol, 0, dy, dx, -dy);
    popMatrix();

    pushMatrix();
    float changeScaleDisplayWidth2 = width/13/dx;
    translate(width/2-(C*cos(radians(alpha))*60)/2*changeScaleDisplayWidth2, height/2);
    scale(changeScaleDisplayWidth2,changeScaleDisplayWidth2);
    drawAldehyde(n, positionAldehyde, 0, dy, dx, -dy);
    drawAcid(n, positionCarboxylicGroup, 0, dy, dx, -dy);
    popMatrix();
  }
}

void typeName(int mode, int C) {
  if (defaultLanguage == 0) {
    nameAlkane = new StringList();
    nameAlkane.append("Meth");
    nameAlkane.append("Eth");
    nameAlkane.append("Prop");
    nameAlkane.append("But");
    nameAlkane.append("Pent");
    nameAlkane.append("Hex");
    nameAlkane.append("Hept");
    nameAlkane.append("Oct");
    nameAlkane.append("Non");
    nameAlkane.append("Dec");
  }
  if (defaultLanguage == 1) {
    nameAlkane = new StringList();
    nameAlkane.append("Meth");
    nameAlkane.append("Eth");
    nameAlkane.append("Prop");
    nameAlkane.append("But");
    nameAlkane.append("Pent");
    nameAlkane.append("Hex");
    nameAlkane.append("Hept");
    nameAlkane.append("Okt");
    nameAlkane.append("Non");
    nameAlkane.append("Dec");
  }


  //    println("Number of Atoms" + C);
  if (mode == 0) {
    name = nameAlkane.get(C - 1) + suffixAlkaneL;
  }
  if (mode == 1) {
    name = nameAlkane.get(C - 1) + "-" + str(positionAlkene) + "-" + suffixAlkeneL;
  }
  if (mode == 2) {
    name = nameAlkane.get(C - 1) + "-" + str(positionAlkine) + "-" + suffixAlkineL;
  }
  if (mode == 3) {
    name = nameAlkane.get(C - 1) + suffixAldehydeL;
  }
  if (mode == 4) {
    name = nameAlkane.get(C - 1) + suffixAcidL;
  }
  if (mode == 5) {
    name = nameAlkane.get(C - 1) + suffixAlkaneL + "-" + str(positionAlcohol) + "-" +  suffixAlcoholL;
  }

  //reroll false 1

  if (mode == 0) {
    false1 = nameAlkane.get(C1 - 1) + suffixAlkaneL;
  }
  if (mode == 1) {
    false1 = nameAlkane.get(C1 - 1) + "-" + str(false1positionAlkene) + "-" + suffixAlkeneL;
  }
  if (mode == 2) {
    false1 = nameAlkane.get(C1 - 1) + "-" + str(false1positionAlkine) + "-" + suffixAlkineL;
  }
  if (mode == 3) {
    false1 = nameAlkane.get(C1 - 1) + suffixAldehydeL;
  }
  if (mode == 4) {
    false1 = nameAlkane.get(C1 - 1) + suffixAcidL;
  }
  if (mode == 5) {
    false1 = nameAlkane.get(C1 - 1) + suffixAlkaneL + "-" + str(false1positionAlcohol) + "-" +  suffixAlcoholL;
  }

  //reroll false2

  if (mode2 == 0) {
    false2 = nameAlkane.get(C2 - 1) + suffixAlkaneL;
  }
  if (mode2 == 1) {
    false2 = nameAlkane.get(C2 - 1) + "-" + str(positionAlkene) + "-" + suffixAlkeneL;
  }
  if (mode2 == 2) {
    false2 = nameAlkane.get(C2 - 1) + "-" + str(positionAlkine) + "-" + suffixAlkineL;
  }
  if (mode2 == 3) {
    false2 = nameAlkane.get(C2 - 1) + suffixAldehydeL;
  }
  if (mode2 == 4) {
    false2 = nameAlkane.get(C2 - 1) + suffixAcidL;
  }
  if (mode2 == 5) {
    false2 = nameAlkane.get(C2 - 1) + suffixAlkaneL + "-" + str(positionAlcohol) + "-" +  suffixAlcoholL;
  }

  //reroll false3

  if (mode3 == 0) {
    false3 = nameAlkane.get(C3 - 1) + suffixAlkaneL;
  }
  if (mode3 == 1) {
    false3 = nameAlkane.get(C3 - 1) + "-" + str(positionAlkene) + "-" + suffixAlkeneL;
  }
  if (mode3 == 2) {
    false3 = nameAlkane.get(C3 - 1) + "-" + str(positionAlkine) + "-" + suffixAlkineL;
  }
  if (mode3 == 3) {
    false3 = nameAlkane.get(C3 - 1) + suffixAldehydeL;
  }
  if (mode3 == 4) {
    false3 = nameAlkane.get(C3 - 1) + suffixAcidL;
  }
  if (mode3 == 5) {
    false3 = nameAlkane.get(C3 - 1) + suffixAlkaneL + "-" + str(positionAlcohol) + "-" +  suffixAlcoholL;
  }
}

//buttons go here
public void playButton() {
  menuType = 2;
  if (redraw == 0) {
    //create array with chosen modes
    modeRandom = subset(modeRandom, 0, 0);
    if (Alkane == true) {
      modeRandom = splice(modeRandom, 0, 0);
    }
    if (Alkene == true) {
      modeRandom = splice(modeRandom, 1, 0);
    }
    if (Alkine == true) {
      modeRandom = splice(modeRandom, 2, 0);
    }
    if (Aldehyde == true) {
      modeRandom = splice(modeRandom, 3, 0);
    }
    if (Acid == true) {
      modeRandom = splice(modeRandom, 4, 0);
    }
    if (Alkohole == true) {
      modeRandom = splice(modeRandom, 5, 0);
    }
    int randomModeRandom = round(random(0, modeRandom.length-1));    //round?
    mode = modeRandom[randomModeRandom];
    
    //random chain length, mode 1 and 2 only allows for chain lengths 2 and up (alkene and alkyne)
    if (mode == 1 || mode == 2) {
      C = round(random(2, chainLength));
    } else {
      C = round(random(1, chainLength));
    }
    //three different variables in the domain and different from C-creator
    int a, b, c;
    if (mode == 1 || mode == 2) {
      for (a = C; a == C; a = round(random(2, chainLength)));
      for (b = C; b == C || b == a; b = round(random(2, chainLength)));
      for (c = C; c == C || c == a || c == b; c = round(random(2, chainLength)));
    } else {
      for (a = C; a == C; a = round(random(1, chainLength)));
      for (b = C; b == C || b == a; b = round(random(1, chainLength)));
      for (c = C; c == C || c == a || c == b; c = round(random(1, chainLength)));
    }
    println(C);
    println(a);
    println(b);
    println(c);
    C1 = a;
    println(modeRandom.length);
    println(modeRandom);

    mode2 = modeRandom[round(random(0, modeRandom.length-1))];
    C2 = b;
    mode3 = modeRandom[round(random(0, modeRandom.length-1))];
    C3 = c;
    mode2 = mode;
    C3 = c;
    positionAlkene = round(random(1, floor(C/2)));              //definition and parameters for the position of special stuff ... (e.g. functional groups of alcohol)
    false1positionAlkene = round(random(1, floor(C1/2)));
    false2positionAlkene = round(random(1, floor(C1/2)));
    false3positionAlkene = round(random(1, floor(C1/2)));
    positionAlkine = round(random(1, floor(C/2)));
    false1positionAlkine = round(random(1, floor(C1/2)));
    false2positionAlkene = round(random(1, floor(C1/2)));
    false3positionAlkene = round(random(1, floor(C1/2)));
    positionAlcohol = round(random(1, ceil(C/2)));
    false1positionAlcohol = round(random(1, ceil(C1/2)));
    false2positionAlkene = round(random(1, floor(C1/2)));
    false3positionAlkene = round(random(1, floor(C1/2)));
    positionAldehyde = C - 1;
    positionCarboxylicGroup = C - 1;
    randomPos1.shuffle();

    redraw += 1;
  }
}
public void settingsButton() {
  menuType = 3;
}
public void languageButton() {
  menuType = 4;
}
public void helpButton() {
  menuType = 5;
}
public void languagesList(int i) {
  defaultLanguage = i-1;
}
public void toggleAlkane(boolean theFlag) {
  if (theFlag == true) {
    Alkane = true;
    redraw = 0;
  } else {
    Alkane = false;
    redraw = 0;
  }
}
public void toggleAlkene(boolean theFlag) {
  if (theFlag == true) {
    Alkene = true;
    redraw = 0;
  } else {
    Alkene = false;
    redraw = 0;
  }
}
public void toggleAlkine(boolean theFlag) {
  if (theFlag == true) {
    Alkine = true;
    redraw = 0;
  } else {
    Alkine = false;
    redraw = 0;
  }
}
public void toggleAldehyde(boolean theFlag) {
  if (theFlag == true) {
    Aldehyde = true;
    redraw = 0;
  } else {
    Aldehyde = false;
    redraw = 0;
  }
}
public void toggleAcid(boolean theFlag) {
  if (theFlag == true) {
    Acid = true;
    redraw = 0;
  } else {
    Acid = false;
    redraw = 0;
  }
}
public void toggleAlkohole(boolean theFlag) {
  if (theFlag == true) {
    Alkohole = true;
    redraw = 0;
  } else {
    Alkohole = false;
    redraw = 0;
  }
}


public void backButton() {
  menuType = 1;
}
public void resetButton() {
  int randomModeRandom = round(random(0, modeRandom.length-1));    //round?
  mode = modeRandom[randomModeRandom];
  int Crand = C;
  while (Crand == C) {
    if (mode == 1 || mode == 2) {
      Crand = round(random(2, chainLength));
    } else {
      Crand = round(random(1, chainLength));
    }
  }
  C = Crand;
  int a, b, c;
  if (mode == 1 || mode == 2) {
    for (a = C; a == C; a = round(random(2, chainLength)));
    for (b = C; b == C || b == a; b = round(random(2, chainLength)));
    for (c = C; c == C || c == a || c == b; c = round(random(2, chainLength)));
  } else {
    for (a = C; a == C; a = round(random(1, chainLength)));
    for (b = C; b == C || b == a; b = round(random(1, chainLength)));
    for (c = C; c == C || c == a || c == b; c = round(random(1, chainLength)));
  }
  println(C);
  println(a);
  println(b);
  println(c);
  C1 = a;
  println(modeRandom.length);
  println(modeRandom);
  mode2 = modeRandom[round(random(0, modeRandom.length-1))];
  C2 = b;
  mode3 = modeRandom[round(random(0, modeRandom.length-1))];
  C3 = c;
  positionAlkene = round(random(1, floor(C/2)));
  false1positionAlkene = round(random(1, floor(C1/2)));
  false2positionAlkene = round(random(1, floor(C1/2)));
  false3positionAlkene = round(random(1, floor(C1/2)));
  positionAlkine = round(random(1, floor(C/2)));
  false1positionAlkine = round(random(1, floor(C1/2)));
  false2positionAlkene = round(random(1, floor(C1/2)));
  false3positionAlkene = round(random(1, floor(C1/2)));
  positionAlcohol = round(random(1, ceil(C/2)));
  false1positionAlcohol = round(random(1, ceil(C1/2)));
  false2positionAlkene = round(random(1, floor(C1/2)));
  false3positionAlkene = round(random(1, floor(C1/2)));
  positionCarboxylicGroup = C - 1;
  randomPos1.shuffle();
  f1 = color(121, 149, 255);
  f1to = f1;
  f2 = color(121, 149, 255);
  f2to = f2;
  f3 = color(121, 149, 255);
  f3to = f3;
  trueCounter = 0;
  falseCounter = 0;
}
public void trueButton() { //////////////////////////
  int randomModeRandom = round(random(0, modeRandom.length-1));    //round?
  mode = modeRandom[randomModeRandom];
  int Crand = C;
  while (Crand == C) {
    if (mode == 1 || mode == 2) {
      Crand = round(random(2, chainLength));
    } else {
      Crand = round(random(1, chainLength));
    }
  }
  C = Crand;
  int a, b, c;
  if (mode == 1 || mode == 2) {
    for (a = C; a == C; a = round(random(2, chainLength)));
    for (b = C; b == C || b == a; b = round(random(2, chainLength)));
    for (c = C; c == C || c == a || c == b; c = round(random(2, chainLength)));
  } else {
    for (a = C; a == C; a = round(random(1, chainLength)));
    for (b = C; b == C || b == a; b = round(random(1, chainLength)));
    for (c = C; c == C || c == a || c == b; c = round(random(1, chainLength)));
  }
  println(C);
  println(a);
  println(b);
  println(c);
  C1 = a;
  println(modeRandom.length);
  println(modeRandom);
  mode2 = modeRandom[round(random(0, modeRandom.length-1))];
  C2 = b;
  mode3 = modeRandom[round(random(0, modeRandom.length-1))];
  C3 = c;

  positionAlkene = round(random(1, floor(C/2)));
  false1positionAlkene = round(random(1, floor(C1/2)));
  false2positionAlkene = round(random(1, floor(C1/2)));
  false3positionAlkene = round(random(1, floor(C1/2)));
  positionAlkine = round(random(1, floor(C/2)));
  false1positionAlkine = round(random(1, floor(C1/2)));
  false2positionAlkene = round(random(1, floor(C1/2)));
  false3positionAlkene = round(random(1, floor(C1/2)));
  positionAlcohol = round(random(1, ceil(C/2)));
  false1positionAlcohol = round(random(1, ceil(C1/2)));
  false2positionAlkene = round(random(1, floor(C1/2)));
  false3positionAlkene = round(random(1, floor(C1/2)));

  positionCarboxylicGroup = C - 1;

  trueCounter = trueCounter + 1;
  randomPos1.shuffle();
  f1 = color(121, 149, 255);
  f1to = f1;
  f2 = color(121, 149, 255);
  f2to = f2;
  f3 = color(121, 149, 255);
  f3to = f3;
}

public void falseButton1() { //////////////////////////
  if (f1to == color(121, 149, 255)) {
    falseCounter = falseCounter + 1;
  }
  f1to = color(191, 87, 87);
}
public void falseButton2() { //////////////////////////
  if (f2to == color(121, 149, 255)) {
    falseCounter = falseCounter + 1;
  }
  f2to = color(191, 87, 87);
}
public void falseButton3() { //////////////////////////
  if (f3to == color(121, 149, 255)) {
    falseCounter = falseCounter + 1;
  }
  f3to = color(191, 87, 87);
}



//Alkane
void drawAlkane(int n, int x1, float y1, float dx, float y2) {          //further explanations in the matura project protocol
  if (mode == 0) {
    if (C >= 2) {                                                       //ethan or higher
      for (; n < C - 1; n = n + 1) {
        strokeJoin(ROUND);
        beginShape(LINES);
        vertex(x1 + n * dx, y1 * ((n + 1) % 2) + y2 * (n % 2));
        vertex(x1 + (n + 1) * dx, y1 * (+n % 2) + y2 * ((n + 1) % 2));
        endShape(CLOSE);
        text("test", width/2, height/2);
      }
    }
    if (C == 1) {                                                       //Methan need it's own function, as it's a different formula
      popMatrix();
      pushMatrix();
      float changeScaleDisplayWidth1 = width/12/dx;
      //scale(changeScaleDisplayWidth1,changeScaleDisplayWidth1);
      translate(-width/2*(changeScaleDisplayWidth1-1),-height/2*(changeScaleDisplayWidth1-1));
      scale(changeScaleDisplayWidth1,changeScaleDisplayWidth1);
      textAlign(CENTER, CENTER);
      stroke(0);
      textSize(dx/2);
      text("C", width/2, height/2);
      text("H", width/2+dx, height/2);
      text("H", width/2, height/2+dx);
      text("H", width/2-dx, height/2);
      text("H", width/2, height/2-dx);
      beginShape();
      vertex(width/2+textWidth("C"), height/2);
      vertex(width/2+dx-textWidth("C"), height/2);
      endShape(); 
      beginShape();
      vertex(width/2-textWidth("C"), height/2);
      vertex(width/2-dx+textWidth("C"), height/2);
      endShape(); 
      beginShape();
      vertex(width/2, height/2+dx/5*2);
      vertex(width/2, height/2+dx-textWidth("C")/3*2);
      endShape(); 
      beginShape();
      vertex(width/2, height/2-textWidth("C"));
      vertex(width/2, height/2-dx+textWidth("C"));
      endShape(); 
      popMatrix();
      pushMatrix();
    }
  }
}

//Alkene


void drawAlkene(int n, int positionAlkene, int x1, float y1, float dx, float y2) {
  if (mode == 1) {
    int realpositionAlkene = positionAlkene - 1;
    for (; n < C - 1; n = n + 1) {
      strokeJoin(ROUND);
      beginShape(LINES);
      vertex(x1 + n * dx, y1 * ((n + 1) % 2) + y2 * (n % 2));
      vertex(x1 + (n + 1) * dx, y1 * (+n % 2) + y2 * ((n + 1) % 2));
      endShape(CLOSE);
    }
    if (C == 2){                                                                          //has to look slightly different
      beginShape(LINES);
        vertex(x1 + v1.x + realpositionAlkene * dx, y1 + v1.y);
        vertex(v1.x - x1 + (1 + realpositionAlkene) * dx, y2+v1.y);
        endShape();
    }else if (positionAlkene <= (C - C % 2) / 2) { //check for true value
      if (realpositionAlkene % 2 == 0) { //odd or even
        beginShape(LINES);                                                                //special extra lines         
        vertex(x1 + v1.x + realpositionAlkene * dx, y1 + v1.y);
        vertex(v1.x - vy.x + x1 + (realpositionAlkene + 1) * dx, y2 - vy.y);
        endShape();
      } else {
        beginShape(LINES);
        vertex(x1 + v1.x + realpositionAlkene * dx, y2 - v1.y);
        vertex(v1.x - vy.x + x1 + (1 + realpositionAlkene) * dx, y1 + vy.y);
        endShape(LINES);
      }
    } else {
      println("Error at positionAlkene");
    }
  }
}

//Alkine


void drawAlkine(int n, int positionAlkine, int x1, float y1, float dx, float y2) {
  if (mode == 2) {
    int realpositionAlkine = positionAlkine - 1;
    if (positionAlkine <= (C - C % 2) / 2) { //check for true value
      if (realpositionAlkine % 2 == 0) { //odd or even
        beginShape(LINES); //middle Line
        vertex(x1 + (realpositionAlkine) * dx, y1 * ((realpositionAlkine + 1) % 2) + y2 * (realpositionAlkine % 2));
        vertex(x1 + (realpositionAlkine + 1) * dx, y1 * (realpositionAlkine % 2) + y2 * ((realpositionAlkine + 1) % 2) + ydown.y);
        endShape(LINES);

        beginShape(LINES); //upper Line
        vertex(x1 + (realpositionAlkine) * dx + VAlkine.x, y1 * ((realpositionAlkine + 1) % 2) + y2 * (realpositionAlkine % 2) - VAlkine.y);
        vertex(x1 + (realpositionAlkine + 1) * dx + VAlkine.x, y1 * (realpositionAlkine % 2) + y2 * ((realpositionAlkine + 1) % 2) + ydown.y - VAlkine.y);
        endShape(LINES);

        beginShape(LINES); //lower Line
        vertex(x1 + (realpositionAlkine) * dx - VAlkine.x, y1 * ((realpositionAlkine + 1) % 2) + y2 * (realpositionAlkine % 2) + VAlkine.y);
        vertex(x1 + (realpositionAlkine + 1) * dx - VAlkine.x, y1 * (realpositionAlkine % 2) + y2 * ((realpositionAlkine + 1) % 2) + ydown.y + VAlkine.y);
        endShape(LINES);
      } else {
        beginShape(LINES); //middle Line
        vertex(x1 + (realpositionAlkine) * dx, y1 * ((realpositionAlkine + 1) % 2) + y2 * (realpositionAlkine % 2));
        vertex(x1 + (realpositionAlkine + 1) * dx, y1 * (realpositionAlkine % 2) + y2 * ((realpositionAlkine + 1) % 2) + yup.y);
        endShape(LINES);

        beginShape(LINES); //upper Line
        vertex(x1 + (realpositionAlkine) * dx - VAlkine.x, y1 * ((realpositionAlkine + 1) % 2) + y2 * (realpositionAlkine % 2) - VAlkine.y);
        vertex(x1 + (realpositionAlkine + 1) * dx - VAlkine.x, y1 * (realpositionAlkine % 2) + y2 * ((realpositionAlkine + 1) % 2) + yup.y - VAlkine.y);
        endShape(LINES);

        beginShape(LINES); //lower Line
        vertex(x1 + (realpositionAlkine) * dx + VAlkine.x, y1 * ((realpositionAlkine + 1) % 2) + y2 * (realpositionAlkine % 2) + VAlkine.y);
        vertex(x1 + (realpositionAlkine + 1) * dx + VAlkine.x, y1 * (realpositionAlkine % 2) + y2 * ((realpositionAlkine + 1) % 2) + yup.y + VAlkine.y);
        endShape(LINES);
      }
      //deformation
      for (; n < realpositionAlkine; n = n + 1) { 
        strokeJoin(ROUND);
        beginShape(LINES);
        vertex(x1 + n * dx, y1 * ((n + 1) % 2) + y2 * (n % 2));
        vertex(x1 + (n + 1) * dx, y1 * (+n % 2) + y2 * ((n + 1) % 2));
        endShape(CLOSE);
      }
      if (positionAlkine % 2 == 0) {
        for (; positionAlkine < C - 1; positionAlkine = positionAlkine + 1) {
          strokeJoin(ROUND);
          beginShape(LINES);
          vertex(x1 + positionAlkine * dx, y1 * ((positionAlkine + 1) % 2) + yup.y + y2 * (positionAlkine % 2));
          vertex(x1 + (positionAlkine + 1) * dx, y1 * (positionAlkine % 2) + yup.y + y2 * ((positionAlkine + 1) % 2));
          endShape(CLOSE);
        }
      } else {
        for (; positionAlkine < C - 1; positionAlkine = positionAlkine + 1) {
          strokeJoin(ROUND);
          beginShape(LINES);
          vertex(x1 + positionAlkine * dx, y1 * ((positionAlkine + 1) % 2) + ydown.y + y2 * (positionAlkine % 2));
          vertex(x1 + (positionAlkine + 1) * dx, y1 * (positionAlkine % 2) + ydown.y + y2 * ((positionAlkine + 1) % 2));
          endShape(CLOSE);
        }
      }
    } else {
      println("Error at positionAlkine");
    }
  }
}

//Aldehyde


void drawAldehyde(int n, int positionAldehyde, int x1, float y1, float dx, float y2) {
  if (mode == 3) {
    if ( C > 1) {
      for (; n < C - 1; n = n + 1) {
        strokeJoin(ROUND);
        beginShape(LINES);
        vertex(x1 + n * dx, y1 * ((n + 1) % 2) + y2 * (n % 2));
        vertex(x1 + (n + 1) * dx, y1 * (+n % 2) + y2 * ((n + 1) % 2));
        endShape(CLOSE);
      }
      beginShape(LINES);
      vertex(x1 + positionAldehyde * dx, y1 * ((positionAldehyde + 1) % 2) + y2 * (positionAldehyde % 2));
      vertex(x1 + (positionAldehyde + 1) * dx - VAldehydeBV.x, y1 * (positionAldehyde % 2) + y2 * ((positionAldehyde + 1) % 2) - VAldehydeBV.y * (positionAldehyde % 2) + VAldehydeBV.y * ((positionAldehyde + 1) % 2));
      endShape(CLOSE);
      if (positionAldehyde % 2 == 0) { //odd or even
        beginShape(LINES);
        vertex(x1 + positionAldehyde * dx, y1 + vy.y);
        vertex(x1 - v1.x + (positionAldehyde + 1) * dx - VAldehydeBV.x, y2 - v1.y + VAldehydeBV.y);
        endShape(LINES);
        textAlign(LEFT, BOTTOM / 2);
        textSize(32);
        text("O", x1 - VAldehydeO.x + (positionAldehyde + 1) * dx, y2 - VAldehydeO.y);
      } else {
        beginShape(LINES);
        vertex(x1 + positionAldehyde * dx, y2 - vy.y);
        vertex(x1 - v1.x + (1 + positionAldehyde) * dx - VAldehydeBV.x, y1 + v1.y - VAldehydeBV.y);
        endShape(LINES);
        textAlign(LEFT, TOP);
        textSize(32);
        text("O", x1 - VAldehydeO.x + (positionAldehyde + 1) * dx, y1 - VAldehydeO.y);
      }
    }
    if (C == 1) {
      popMatrix();
      float changeScaleDisplayWidth2 = width/13/dx;
      scale(changeScaleDisplayWidth2,changeScaleDisplayWidth2);
      textAlign(CENTER, CENTER);
      stroke(0);
      textSize(dx/2);
      text("C", width/2, height/2);
      text("O", width/2, height/2-dx);
      text("H", width/2-methanHshiftx*dx, height/2+methanHshifty*dx);
      text("H", width/2+methanHshiftx*dx, height/2+methanHshifty*dx);
      beginShape();
      vertex(width/2-methanHshiftx*textWidth("C"), height/2+methanHshifty*textWidth("C"));
      vertex(width/2-methanHshiftx*dx+methanHshiftx*textWidth("C"), height/2+methanHshifty*dx-methanHshifty*textWidth("C"));
      endShape(); 
      beginShape();
      vertex(width/2+methanHshiftx*textWidth("C"), height/2+methanHshifty*textWidth("C"));
      vertex(width/2+methanHshiftx*dx-methanHshiftx*textWidth("C"), height/2+methanHshifty*dx-methanHshifty*textWidth("C"));
      endShape(); 
      beginShape();
      vertex(width/2+VAcidO.x, height/2-textWidth("C"));
      vertex(width/2+VAcidO.x, height/2-dx+textWidth("C"));
      endShape(); 
      beginShape();
      vertex(width/2-VAcidO.x, height/2-textWidth("C"));
      vertex(width/2-VAcidO.x, height/2-dx+textWidth("C"));
      endShape(); 
      pushMatrix();
    }
  }
}

//Carboxylic acid


void drawAcid(int n, int positionCarboxylicGroup, int x1, float y1, float dx, float y2) {
  if (mode == 4) {
    if (C > 1) {
      for (; n < C - 1; n = n + 1) {
        strokeJoin(ROUND);
        beginShape(LINES);
        vertex(x1 + n * dx, y1 * ((n + 1) % 2) + y2 * (n % 2));
        vertex(x1 + (n + 1) * dx, y1 * (+n % 2) + y2 * ((n + 1) % 2));
        endShape(CLOSE);
      }
      beginShape(LINES);
      vertex(x1 + positionCarboxylicGroup * dx, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2));
      vertex(x1 + (positionCarboxylicGroup + 1) * dx - VAldehydeBV.x, y1 * (positionCarboxylicGroup % 2) + y2 * ((positionCarboxylicGroup + 1) % 2) - VAldehydeBV.y * (positionCarboxylicGroup % 2) + VAldehydeBV.y * ((positionCarboxylicGroup + 1) % 2));
      endShape(CLOSE);
      if (positionCarboxylicGroup % 2 == 0) { //odd or even
        beginShape(LINES);
        vertex(x1 + positionCarboxylicGroup * dx - VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) + VAcidO.y);
        vertex(x1 + positionCarboxylicGroup * dx - VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) + 40);
        endShape(LINES);
        beginShape(LINES);
        vertex(x1 + positionCarboxylicGroup * dx + VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) + VAcidO.y);
        vertex(x1 + positionCarboxylicGroup * dx + VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) + 40);
        endShape(LINES);
        textAlign(LEFT, CENTER);
        textSize(32);
        text("OH", x1 + (positionCarboxylicGroup + 1) * dx, y2);
        textAlign(CENTER, CENTER);
        text("O", x1 + positionCarboxylicGroup * dx, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) + 60);
      } else {
        beginShape(LINES);
        vertex(x1 + positionCarboxylicGroup * dx - VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) + VAcidO.y);
        vertex(x1 + positionCarboxylicGroup * dx - VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) - 40);
        endShape(LINES);
        beginShape(LINES);
        vertex(x1 + positionCarboxylicGroup * dx + VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) + VAcidO.y);
        vertex(x1 + positionCarboxylicGroup * dx + VAcidO.x, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) - 40);
        endShape(LINES);
        textAlign(LEFT, CENTER);
        textSize(32);
        text("OH", x1 + (positionCarboxylicGroup + 1) * dx, y1);
        textAlign(CENTER, CENTER);
        text("O", x1 + positionCarboxylicGroup * dx, y1 * ((positionCarboxylicGroup + 1) % 2) + y2 * (positionCarboxylicGroup % 2) - 60);
      }
    }
    if (C == 1) {
      popMatrix();
      float changeScaleDisplayWidth2 = width/13/dx;
      scale(changeScaleDisplayWidth2,changeScaleDisplayWidth2);
      textAlign(CENTER, CENTER);
      stroke(0);
      textSize(dx/2);
      text("C", width/2, height/2);
      text("O", width/2, height/2-dx);
      text("H", width/2-methanHshiftx*dx, height/2+methanHshifty*dx);
      text("OH", width/2+methanHshiftx*dx+textWidth("O")/2, height/2+methanHshifty*dx);
      beginShape();
      vertex(width/2-methanHshiftx*textWidth("C"), height/2+methanHshifty*textWidth("C"));
      vertex(width/2-methanHshiftx*dx+methanHshiftx*textWidth("C"), height/2+methanHshifty*dx-methanHshifty*textWidth("C"));
      endShape(); 
      beginShape();
      vertex(width/2+methanHshiftx*textWidth("C"), height/2+methanHshifty*textWidth("C"));
      vertex(width/2+methanHshiftx*dx-methanHshiftx*textWidth("C"), height/2+methanHshifty*dx-methanHshifty*textWidth("C"));
      endShape(); 
      beginShape();
      vertex(width/2+VAcidO.x, height/2-textWidth("C"));
      vertex(width/2+VAcidO.x, height/2-dx+textWidth("C"));
      endShape(); 
      beginShape();
      vertex(width/2-VAcidO.x, height/2-textWidth("C"));
      vertex(width/2-VAcidO.x, height/2-dx+textWidth("C"));
      endShape(); 
      pushMatrix();
    }
  }
}
//Alcohol

void drawAlcohol(int n, int positionAlcohol, int x1, float y1, float dx, float y2) {
  if (mode == 5) {
    int realpositionAlcohol = positionAlcohol - 1;
    if (C>1) {
      for (; n < C - 1; n = n + 1) {
        strokeJoin(ROUND);
        beginShape(LINES);
        vertex(x1 + n * dx, y1 * ((n + 1) % 2) + y2 * (n % 2));
        vertex(x1 + (n + 1) * dx, y1 * (+n % 2) + y2 * ((n + 1) % 2));
        endShape(CLOSE);
      }
      if (realpositionAlcohol == 0) {
        strokeJoin(ROUND);

        beginShape(LINES);
        vertex(x1, y1);
        vertex(x1 - dx, y2);
        endShape(CLOSE);

         //HO-Group if its position is at 1
        textSize(32);
        textAlign(CENTER,CENTER);
        text("HO", x1 + (realpositionAlcohol-1) * dx-textWidth("O")-5, y2-5);
        
      } else if (positionAlcohol % 2 == 0) { //odd or even
        beginShape(LINES);
        vertex(x1 + realpositionAlcohol * dx, y1 * ((realpositionAlcohol + 1) % 2) + y2 * (realpositionAlcohol % 2) + VAcidO.y);
        vertex(x1 + realpositionAlcohol * dx, y1 * ((realpositionAlcohol + 1) % 2) + y2 * (realpositionAlcohol % 2) - 40);
        endShape(LINES);

        textAlign(CENTER,BOTTOM);
        textSize(32);
        text("OH", x1 + realpositionAlcohol * dx+textWidth("O")/2, y1 * ((realpositionAlcohol + 1) % 2) + y2 * (realpositionAlcohol % 2) - 45);

      } else {
        beginShape(LINES);
        vertex(x1 + realpositionAlcohol * dx, y1 * ((realpositionAlcohol + 1) % 2) + y2 * (realpositionAlcohol % 2) + VAcidO.y);
        vertex(x1 + realpositionAlcohol * dx, y1 * ((realpositionAlcohol + 1) % 2) + y2 * (realpositionAlcohol % 2) + 40);
        endShape(LINES);
        
        textAlign(CENTER, TOP);
        textSize(32);
        text("OH", x1 + realpositionAlcohol * dx+textWidth("O")/2, y1 * ((realpositionAlcohol + 1) % 2) + y2 * (realpositionAlcohol % 2) + 45);
      }
    }
    if (C == 1) {
      popMatrix();
      float changeScaleDisplayWidth1 = width/12/dx;
      scale(changeScaleDisplayWidth1,changeScaleDisplayWidth1);
      textAlign(CENTER, CENTER);
      stroke(0);
      textSize(dx/2);
      text("C", width/2, height/2);
      text("OH", width/2+dx+textWidth("O")/2, height/2);
      text("H", width/2, height/2+dx);
      text("H", width/2-dx, height/2);
      text("H", width/2, height/2-dx);
      beginShape();
      vertex(width/2+textWidth("C"), height/2);
      vertex(width/2+dx-textWidth("C"), height/2);
      endShape(); 
      beginShape();
      vertex(width/2-textWidth("C"), height/2);
      vertex(width/2-dx+textWidth("C"), height/2);
      endShape(); 
      beginShape();
      vertex(width/2, height/2+dx/5*2);
      vertex(width/2, height/2+dx-textWidth("C")/3*2);
      endShape(); 
      beginShape();
      vertex(width/2, height/2-textWidth("C"));
      vertex(width/2, height/2-dx+textWidth("C"));
      endShape(); 
      pushMatrix();
    }
  }
}
//stop