//+------------------------------------------------------------------+
//|                                                 TradingPanel.mqh |
//|             Copyright 2018, Kashu Yamazaki, All Rights Reserved. |
//|                                      https://Kashu7100.github.io |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Kashu"
#property strict

#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>
#include <Controls\Button.mqh>
#include <Controls\ComboBox.mqh>
#include <TradingAgent.mqh>

#resource "\\Include\\Controls\\res\\CheckBoxOn.bmp"
#resource "\\Include\\Controls\\res\\CheckBoxOff.bmp"
#resource "\\Include\\Controls\\res\\SpinInc.bmp"
#resource "\\Include\\Controls\\res\\SpinDec.bmp"

enum ENUM_LABEL_ALIGN{
   LEFT = -1,
   CENTER = 0,
   RIGHT = 1
};

class TradingPanel:public CAppDialog{
   public:
      void TradingPanel(int accountNum,ENUM_POSITION_HANDLING position_handling=LONG_SHORT, bool autoTrailing=true, double startSL=15, 
                           double basic_SLwidth=10, double risk=4, double SL=15, double TP=30);
      void ~TradingPanel();
      bool Init(int accountNum,ENUM_POSITION_HANDLING position_handling=LONG_SHORT,bool autoTrailing=true,double startSL=15.000000,
                   double basic_SLwidth=10.000000,double risk=4, double SL=15, double TP=30);
      
      virtual bool Create(const string name, const int x1=5,const int y1=20,const int x2=320,const int y2=420);
      virtual void Update(void);
      void OnTime(void);
      virtual bool OnEvent(const int id,const long &lparam, const double &dparam, const string &sparam);
   
   private:
      bool CreateLabel(CLabel &object, const string text, const uint x, const uint y, ENUM_LABEL_ALIGN align);
      bool CreateEdit(CEdit &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size);
      bool CreateBmpButton(CBmpButton &object,const uint x,const uint y,string BmpON,string BmpOFF,bool lock);
      bool CreateButton(CButton &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size); 
      bool CreateComboBox(CComboBox &object,const uint x,const uint y,const uint x_size,const uint y_size);  
      
      // On Event
      void Edit_Lots(void);
      void Edit_Amount(void);
      void Edit_SL(void);
      void Edit_TP(void);
      void Click_AutoLots(void);
      void Click_FixVolume(void);
      void Click_SL(void);
      void Click_TP(void);
      void Click_Trailing(void);
      void Click_IncreaseLots(void);
      void Click_DecreaseLots(void);
      void Click_IncreaseAmount(void);
      void Click_DecreaseAmount(void);
      void Click_IncreaseSL(void);
      void Click_DecreaseSL(void);
      void Click_IncreaseTP(void);
      void Click_DecreaseTP(void);
      void Click_OrderSell(void);
      void Click_OrderCross(void);
      void Click_OrderBuy(void);
      void Click_CloseAllSell(void);
      void Click_CloseAll(void);
      void Click_CloseAllBuy(void); 
      
   protected:
      CLabel            mAsk_value, mSpread_value, mBid_value;                      // Display Ask and Bid prices
      CLabel            mFixVolume_label, mAmount_label;                            //
      CLabel            mAutoLots_label, mLots1_label;                              //
      CLabel            mAutoSL_label, mSL_label;                                   //
      CLabel            mAutoTP_label, mTP_label;                                   //
      CLabel            mAllowTrailing_label, mTrailingType_label;                  //
      CLabel            mSellPositions_value, mPositions_label, mBuyPositions_value;//
      CLabel            mSellLots_value, mLots2_label, mBuyLots_value;              //
      CLabel            mSellBE_value, mBE_label, mBuyBE_value;                     //
      CLabel            mSellProfit_value, mProfit_label, mBuyProfit_value;         //
      CLabel            mEquity_label, mEquity_value;                               // 
      CLabel            mMarginLevel_label, mMarginLevel_value;                     //
      CLabel            mLeverage_label, mLeverage_value;                           //
      CComboBox         mTrailingType_box;                                          //
      CEdit             mAmount_input;                                              //
      CEdit             mLots_input;                                                //
      CEdit             mSL_input;                                                  //
      CEdit             mTP_input;                                                  //
      CBmpButton        mAutoLots_button, mFixVolume_button;                        //
      CBmpButton        mAutoSL_button, mSL_button;                                 //
      CBmpButton        mAutoTP_button, mTP_button;                                 //
      CBmpButton        mTrailing_button;                                           //
      CBmpButton        mIncreaseAmount_button, mDecreaseAmount_button;             // Increase and Decrease buttons
      CBmpButton        mIncreaseLots_button, mDecreaseLots_button;                 // Increase and Decrease buttons
      CBmpButton        mIncreaseSL_button, mDecreaseSL_button;                     // Increase and Decrease buttons
      CBmpButton        mIncreaseTP_button, mDecreaseTP_button;                     // Increase and Decrease buttons
      CButton           mOrderSell_button, mOrderCross_button, mOrderBuy_button;    // Sell, Cross, and Buy Buttons
      CButton           mCloseAllSell_button, mCloseAll_button, mCloseAllBuy_button;// Close buttons
      
      uint   mAmount;
      double mLots;
      bool mFixVolume;
      double mSL; // [pips]
      double mTP; // [pips]
      bool mEnable_SL;
      bool mEnable_TP;
      bool mEnable_Trailing;
      TradingAgent mTA;
      
      #define  STEP   (int)(ClientAreaHeight()/18/4)        // height step betwine elements
      #define  HEIGHT (int)(ClientAreaHeight()/18)          // height of element
      #define  BORDER   (int)(ClientAreaHeight()/24)        // distance betwine boder and elements
};

TradingPanel::TradingPanel(int accountNum,ENUM_POSITION_HANDLING position_handling=LONG_SHORT, bool autoTrailing=true, double startSL=15, 
                           double basic_SLwidth=10, double risk=4, double sl=15, double tp=30){
   mSL = sl;
   mTP = tp;
   mTA.Init(accountNum, "", 12345, NONE, LONG_AND_SHORT, position_handling, true, 0.01, autoTrailing, startSL, basic_SLwidth, risk, 0, 0);
}

TradingPanel::~TradingPanel(void){
}

bool TradingPanel::Init(int accountNum,ENUM_POSITION_HANDLING position_handling=LONG_SHORT,bool autoTrailing=true,double startSL=15.000000,
                   double basic_SLwidth=10.000000,double risk=4, double sl=15, double tp=30){
   mSL = sl;
   mTP = tp;
   return mTA.Init(accountNum, "", 12345, NONE, LONG_AND_SHORT, position_handling, true, 0.01, autoTrailing, startSL, basic_SLwidth, risk, 0, 0);             
}

bool TradingPanel::Create(const string name, const int x1=5,const int y1=20,const int x2=320,const int y2=420){
   if(!Create(0,name,0,x1,y1,x2,y2)) return false;
   int l_x_left=BORDER;
   int l_y=BORDER;
   int y_width=HEIGHT;
   int y_sptep=STEP;
   
   if(!CreateLabel(mBid_value,DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits),l_x_left,l_y,LEFT)) return false;
   if(!mBid_value.FontSize(HEIGHT-3)) return false;
   mBid_value.Color(clrRed);
   
   int l_x_right=ClientAreaWidth()-20;

   if(!CreateLabel(mSpread_value,DoubleToString((SymbolInfoDouble(_Symbol,SYMBOL_ASK)-SymbolInfoDouble(_Symbol,SYMBOL_BID))/_Point,0),l_x_right-137.5,l_y,CENTER)) return false;
   if(!mSpread_value.FontSize(HEIGHT-4)) return false;
   if(!CreateLabel(mAsk_value,DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits),l_x_right,l_y,RIGHT)) return false;
   if(!mAsk_value.FontSize(HEIGHT-3)) return false;
   mAsk_value.Color(clrBlue);
   
   l_y+=2*HEIGHT;
   int x_size=(int)((ClientAreaWidth()-40)/3-5);
   
   // Order Send Buttons
   if(!CreateButton(mOrderSell_button,"SELL",l_x_left,l_y,x_size,HEIGHT*2)) return false;
   if(!CreateButton(mOrderCross_button,"CROSS",(l_x_right-l_x_left-x_size)/2+l_x_left,l_y,x_size,HEIGHT*2)) return false;
   if(!CreateButton(mOrderBuy_button,"BUY",(l_x_right-x_size),l_y,x_size,HEIGHT*2)) return false;
   
   l_y+=2*HEIGHT+STEP; 
   if(!CreateBmpButton(mAutoLots_button,l_x_left+15,l_y,"::Include\\Controls\\res\\CheckBoxOn.bmp","::Include\\Controls\\res\\CheckBoxOff.bmp",true)) return false; 
   if(!CreateLabel(mAutoLots_label,"AutoLots",l_x_left+20,l_y,LEFT)) return false;
   
   if(!CreateLabel(mLots1_label,"Volume [lots]",l_x_right-2.1*x_size,l_y,LEFT)) return false;
   if(!CreateEdit(mLots_input,SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN),l_x_right-x_size,l_y,(int)(x_size-CONTROLS_BUTTON_SIZE),HEIGHT)) return false;
   if(!CreateBmpButton(mIncreaseLots_button,l_x_right,(int)(l_y-HEIGHT/4),"::Include\\Controls\\res\\SpinInc.bmp","::Include\\Controls\\res\\SpinInc.bmp",false)) return false;
   if(!CreateBmpButton(mDecreaseLots_button,l_x_right,(int)(l_y+HEIGHT/4),"::Include\\Controls\\res\\SpinDec.bmp","::Include\\Controls\\res\\SpinDec.bmp",false)) return false;
   
   l_y+=HEIGHT+STEP;
   if(!CreateBmpButton(mFixVolume_button,l_x_left+15,l_y,"::Include\\Controls\\res\\CheckBoxOn.bmp","::Include\\Controls\\res\\CheckBoxOff.bmp",true)) return false; 
   if(!CreateLabel(mFixVolume_label,"Fix Volume",l_x_left+20,l_y,LEFT)) return false;

   if(!CreateLabel(mAmount_label,"Amount",l_x_right-1.75*x_size,l_y,LEFT)) return false;
   if(!CreateEdit(mAmount_input,1,l_x_right-x_size,l_y,(int)(x_size-CONTROLS_BUTTON_SIZE),HEIGHT)) return false;
   if(!CreateBmpButton(mIncreaseAmount_button,l_x_right,(int)(l_y-HEIGHT/4),"::Include\\Controls\\res\\SpinInc.bmp","::Include\\Controls\\res\\SpinInc.bmp",false)) return false;
   if(!CreateBmpButton(mDecreaseAmount_button,l_x_right,(int)(l_y+HEIGHT/4),"::Include\\Controls\\res\\SpinDec.bmp","::Include\\Controls\\res\\SpinDec.bmp",false)) return false;
   
   l_y+=HEIGHT+STEP;
   
   if(!CreateBmpButton(mSL_button,l_x_right-2*x_size+6,l_y,"::Include\\Controls\\res\\CheckBoxOn.bmp","::Include\\Controls\\res\\CheckBoxOff.bmp",true)) return false;
   if(!CreateLabel(mSL_label,"SL [pips]",l_x_right-1.9*x_size,l_y,LEFT)) return false;
   if(!CreateEdit(mSL_input,fmax((SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD))/10, mSL),l_x_right-x_size,l_y,(int)(x_size-CONTROLS_BUTTON_SIZE),HEIGHT)) return false;
   if(!CreateBmpButton(mIncreaseSL_button,l_x_right,(int)(l_y-HEIGHT/4),"::Include\\Controls\\res\\SpinInc.bmp","::Include\\Controls\\res\\SpinInc.bmp",false)) return false;
   if(!CreateBmpButton(mDecreaseSL_button,l_x_right,(int)(l_y+HEIGHT/4),"::Include\\Controls\\res\\SpinDec.bmp","::Include\\Controls\\res\\SpinDec.bmp",false)) return false;
   mSL = StringToDouble(mSL_input.Text());
   
   l_y+=HEIGHT+STEP;
   
   if(!CreateBmpButton(mTP_button,l_x_right-2*x_size+6,l_y,"::Include\\Controls\\res\\CheckBoxOn.bmp","::Include\\Controls\\res\\CheckBoxOff.bmp",true)) return false; 
   if(!CreateLabel(mTP_label,"TP [pips]",l_x_right-1.9*x_size,l_y,LEFT)) return false;
   if(!CreateEdit(mTP_input,fmax((SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)-SymbolInfoInteger(_Symbol,SYMBOL_SPREAD))/10, mTP),l_x_right-x_size,l_y,(int)(x_size-CONTROLS_BUTTON_SIZE),HEIGHT)) return false;
   if(!CreateBmpButton(mIncreaseTP_button,l_x_right,(int)(l_y-HEIGHT/4),"::Include\\Controls\\res\\SpinInc.bmp","::Include\\Controls\\res\\SpinInc.bmp",false)) return false;
   if(!CreateBmpButton(mDecreaseTP_button,l_x_right,(int)(l_y+HEIGHT/4),"::Include\\Controls\\res\\SpinDec.bmp","::Include\\Controls\\res\\SpinDec.bmp",false)) return false;
   mTP = StringToDouble(mTP_input.Text());
   
   l_y+=HEIGHT+STEP;
   if(!CreateBmpButton(mTrailing_button,l_x_left+15,l_y,"::Include\\Controls\\res\\CheckBoxOn.bmp","::Include\\Controls\\res\\CheckBoxOff.bmp",true)) return false; 
   if(!CreateLabel(mAllowTrailing_label,"Allow Trailing",l_x_left+20,l_y,LEFT)) return false;
   
   l_y+=HEIGHT+STEP;
   if(!CreateButton(mCloseAllSell_button,"Close Sell",l_x_left,l_y,x_size,HEIGHT)) return false;
   if(!CreateButton(mCloseAll_button,"Close All",(l_x_right-l_x_left-x_size)/2+l_x_left,l_y,x_size,HEIGHT)) return false;
   if(!CreateButton(mCloseAllBuy_button,"Close Buy",(l_x_right-x_size),l_y,x_size,HEIGHT)) return false;
   mCloseAll_button.ColorBackground(clrLightSalmon);
   
   l_y+=HEIGHT+STEP;
   if(!CreateLabel(mSellPositions_value,mTA.PositionsSell(),l_x_right-2.75*x_size,l_y,CENTER)) return false;  
   if(!CreateLabel(mPositions_label,"Positoins",l_x_right-1.65*x_size,l_y,CENTER)) return false;
   if(!CreateLabel(mBuyPositions_value,mTA.PositionsBuy(),l_x_right-0.5*x_size,l_y,CENTER)) return false;  
   
   l_y+=HEIGHT+STEP;
   if(!CreateLabel(mSellLots_value,mTA.LotsSell(),l_x_right-2.75*x_size,l_y,CENTER)) return false; 
   if(!CreateLabel(mLots2_label,"Lots",l_x_right-1.65*x_size,l_y,CENTER)) return false;
   if(!CreateLabel(mBuyLots_value,mTA.LotsBuy(),l_x_right-0.5*x_size,l_y,CENTER)) return false;   
   
   l_y+=HEIGHT+STEP;
   if(!CreateLabel(mSellBE_value,mTA.CalcBreakEvenSell(),l_x_right-2.75*x_size,l_y,CENTER)) return false; 
   if(!CreateLabel(mBE_label,"BE",l_x_right-1.65*x_size,l_y,CENTER)) return false;
   if(!CreateLabel(mBuyBE_value,mTA.CalcBreakEvenBuy(),l_x_right-0.5*x_size,l_y,CENTER)) return false;   
      
   l_y+=HEIGHT+STEP;
   if(!CreateLabel(mSellProfit_value,mTA.CalcProfitSell(),l_x_right-2.75*x_size,l_y,CENTER)) return false; 
   if(!CreateLabel(mProfit_label,"Profits",l_x_right-1.65*x_size,l_y,CENTER)) return false;
   if(!CreateLabel(mBuyProfit_value,mTA.CalcProfitBuy(),l_x_right-0.5*x_size,l_y,CENTER)) return false;
   
   l_y+=HEIGHT+STEP;
   if(!CreateLabel(mEquity_label,"Equity",l_x_left+10,l_y,LEFT)) return false;
   if(!CreateLabel(mEquity_value,mTA.Equity(),l_x_left+x_size,l_y,CENTER)) return false;
   if(!CreateLabel(mMarginLevel_label,"Margin Level",l_x_left+1.65*x_size,l_y,LEFT)) return false;
   if(!CreateLabel(mMarginLevel_value,DoubleToString(mTA.MarginLevel(),0)+"%",l_x_left+3*x_size,l_y,CENTER)) return false;
   return true;
}

void TradingPanel::Update(void){
   if(mEnable_Trailing){
      mTA.TradeUpdate();
      mTA.TradeClose();
   }
   if(mTA.PositionsBuy()==0)
      mTA.ResetLines("BUY");
   if(mTA.PositionsSell()==0)
      mTA.ResetLines("SELL");

   mAsk_value.Text(DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_ASK),(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS)));
   mSpread_value.Text(DoubleToString((SymbolInfoDouble(_Symbol,SYMBOL_ASK)-SymbolInfoDouble(_Symbol,SYMBOL_BID))/_Point,0));
   mBid_value.Text(DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_BID),(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS)));
   if(mAutoLots_button.Pressed())
      mLots_input.Text((mTA.CalcLots()>0)? DoubleToString(mTA.CalcLots(),2):SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN));
   mSL = fmax((SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD))/10, mSL);
   mSL_input.Text(DoubleToString(mSL,1));
   mTP = fmax((SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)-SymbolInfoInteger(_Symbol,SYMBOL_SPREAD))/10, mTP);
   mTP_input.Text(DoubleToString(mTP, 1));
   // Update Positions Info
   mSellPositions_value.Text(mTA.PositionsSell());
   mBuyPositions_value.Text(mTA.PositionsBuy());
   mSellLots_value.Text(DoubleToString(mTA.LotsSell(),2));
   mBuyLots_value.Text(DoubleToString(mTA.LotsBuy(),2));
   mSellBE_value.Text(DoubleToString(mTA.CalcBreakEvenSell(),_Digits));
   mBuyBE_value.Text(DoubleToString(mTA.CalcBreakEvenBuy(),_Digits));
   mSellProfit_value.Text(DoubleToString(mTA.CalcProfitSell(),2));
   mBuyProfit_value.Text(DoubleToString(mTA.CalcProfitBuy(),2));
   // Update Account Info
   mEquity_value.Text(DoubleToString(mTA.Equity(),2));
   mMarginLevel_value.Text(DoubleToString(mTA.MarginLevel(),0)+"%");
   mLeverage_value.Text(mTA.Leverage());
   ChartRedraw();
}

void TradingPanel::OnTime(void){
}

bool TradingPanel::CreateLabel(CLabel &object, const string text, const uint x, const uint y, ENUM_LABEL_ALIGN align){
    string name = m_name+"Label"+(string)ObjectsTotal(0,-1,OBJ_LABEL);
    if(!object.Create(0,name,0,x,y,0,0)) return false;
    if(!object.Text(text)) return false;
    ObjectSetInteger(0,object.Name(),OBJPROP_ANCHOR,(align==LEFT ? ANCHOR_LEFT_UPPER : (align==RIGHT ? ANCHOR_RIGHT_UPPER : ANCHOR_UPPER)));
    if(!Add(object)) return false;
    return true;
}

bool TradingPanel::CreateEdit(CEdit &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size){
   string name = m_name+"Edit"+(string)ObjectsTotal(0,-1,OBJ_EDIT);
   if(!object.Create(0,name,0,x,y,x+x_size,y+y_size)) return false;
   if(!object.Text(text)) return false;
   if(!object.TextAlign(ALIGN_CENTER)) return false;
   if(!object.ReadOnly(false)) return false;
   if(!Add(object)) return false;
   return true;
}

bool TradingPanel::CreateBmpButton(CBmpButton &object,const uint x,const uint y,string BmpON,string BmpOFF,bool lock){
   string name = m_name+"BmpButton"+(string)ObjectsTotal(0,-1,OBJ_BITMAP_LABEL);
   uint y1=(uint)(y-(STEP-CONTROLS_BUTTON_SIZE)/2);
   uint y2=y1+CONTROLS_BUTTON_SIZE;
   if(!object.Create(0,name,0,x-CONTROLS_BUTTON_SIZE,y1,x,y2)) return false;
   if(!object.BmpNames(BmpOFF,BmpON)) return false;
   if(!Add(object)) return false;
   object.Locking(lock);
   return true;
}

bool TradingPanel::CreateButton(CButton &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size){
   string name = m_name+"Button"+(string)ObjectsTotal(0,-1,OBJ_BUTTON);
   if(!object.Create(0,name,0,x,y,x+x_size,y+y_size)) return false;
   if(!object.Text(text)) return false;
   object.Locking(false);
   if(!object.Pressed(false)) return false;
   if(!Add(object)) return false;
   return true;
}

bool TradingPanel::CreateComboBox(CComboBox &object,const uint x,const uint y,const uint x_size,const uint y_size){
   string name = m_name+"ComboBox"+(string)ObjectsTotal(0,-1,OBJ_BUTTON);
   if(!object.Create(0,name,0,x,y,x+x_size,y+y_size)) return false;
   if(!Add(object)) return false;
   if(!object.ItemAdd("NETTING")) return false;
   if(!object.ItemAdd("LONG/SHORT")) return false;
   if(!object.ItemAdd("HEDGING")) return false;
   return true;
}

// OnEvent
EVENT_MAP_BEGIN(TradingPanel)
   ON_EVENT(ON_END_EDIT,mLots_input,        Edit_Lots)
   ON_EVENT(ON_END_EDIT,mAmount_input,      Edit_Amount)
   ON_EVENT(ON_END_EDIT,mSL_input,          Edit_SL)
   ON_EVENT(ON_END_EDIT,mTP_input,          Edit_TP)
   ON_EVENT(ON_CLICK,mAutoLots_button,      Click_AutoLots)
   ON_EVENT(ON_CLICK,mFixVolume_button,     Click_FixVolume)
   ON_EVENT(ON_CLICK,mSL_button,            Click_SL)
   ON_EVENT(ON_CLICK,mTP_button,            Click_TP)
   ON_EVENT(ON_CLICK,mIncreaseLots_button,  Click_IncreaseLots)
   ON_EVENT(ON_CLICK,mDecreaseLots_button,  Click_DecreaseLots)
   ON_EVENT(ON_CLICK,mIncreaseAmount_button,Click_IncreaseAmount)
   ON_EVENT(ON_CLICK,mDecreaseAmount_button,Click_DecreaseAmount)
   ON_EVENT(ON_CLICK,mIncreaseSL_button,    Click_IncreaseSL)
   ON_EVENT(ON_CLICK,mDecreaseSL_button,    Click_DecreaseSL)
   ON_EVENT(ON_CLICK,mIncreaseTP_button,    Click_IncreaseTP)
   ON_EVENT(ON_CLICK,mDecreaseTP_button,    Click_DecreaseTP)
   ON_EVENT(ON_CLICK,mTrailing_button,      Click_Trailing)
   ON_EVENT(ON_CLICK,mOrderSell_button,     Click_OrderSell)
   ON_EVENT(ON_CLICK,mOrderCross_button,    Click_OrderCross)
   ON_EVENT(ON_CLICK,mOrderBuy_button,      Click_OrderBuy)
   ON_EVENT(ON_CLICK,mCloseAllSell_button,  Click_CloseAllSell)
   ON_EVENT(ON_CLICK,mCloseAll_button,      Click_CloseAll)
   ON_EVENT(ON_CLICK,mCloseAllBuy_button,   Click_CloseAllBuy)
EVENT_MAP_END(CAppDialog)

void TradingPanel::Edit_Lots(void){
   mLots = StringToDouble(mLots_input.Text());
   mLots_input.Text(DoubleToString(mLots,2));
   ChartRedraw();
}

void TradingPanel::Edit_Amount(void){
   mAmount = mAmount_input.Text();
   mAmount_input.Text(IntegerToString(mAmount,2)); 
   ChartRedraw();
}

void TradingPanel::Edit_SL(void){
   mSL = fmax(StringToDouble(mSL_input.Text()),(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD))/10);
   mSL_input.Text(DoubleToString(mSL,1));
   ChartRedraw();
}

void TradingPanel::Edit_TP(void){
   mTP = fmax(StringToDouble(mTP_input.Text()),(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)-SymbolInfoInteger(_Symbol,SYMBOL_SPREAD))/10);
   mTP_input.Text(DoubleToString(mTP,1));
   ChartRedraw();
}

void TradingPanel::Click_AutoLots(void){
   if(mAutoLots_button.Pressed())
      mLots_input.Text((mTA.CalcLots()>0)? DoubleToString(mTA.CalcLots(),2):SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN));
   ChartRedraw();
}

void TradingPanel::Click_FixVolume(void){
   if(mFixVolume_button.Pressed())
      mFixVolume = true;
   else
      mFixVolume = false;   
   ChartRedraw();
}

void TradingPanel::Click_SL(void){
   if(mSL_button.Pressed())
      mEnable_SL = true;
   else
      mEnable_SL = false;
   ChartRedraw();
}

void TradingPanel::Click_TP(void){
   if(mTP_button.Pressed())
      mEnable_TP = true;
   else
      mEnable_TP = false;
   ChartRedraw();
}

void TradingPanel::Click_IncreaseLots(void){
   mLots += SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   mLots_input.Text(DoubleToString(mLots,2));
   ChartRedraw();
}

void TradingPanel::Click_DecreaseLots(void){
   mLots = (mLots-SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP)>0)?(mLots-SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP)):(SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN));
   mLots_input.Text(DoubleToString(mLots,2));
   ChartRedraw();
}

void TradingPanel::Click_IncreaseAmount(void){
   mAmount += 1;
   mAmount_input.Text(IntegerToString(mAmount,2));
   ChartRedraw();
}

void TradingPanel::Click_DecreaseAmount(void){
   mAmount = (mAmount-1>0)?(mAmount-1):(1);
   mAmount_input.Text(IntegerToString(mAmount,2));
   ChartRedraw();
}

void TradingPanel::Click_IncreaseSL(void){
   mSL += 1;//_Point;
   mSL_input.Text(DoubleToString(mSL,1));
   ChartRedraw();
}

void TradingPanel::Click_DecreaseSL(void){
   mSL -= 1;//_Point;
   mSL_input.Text(DoubleToString(mSL,1));
   ChartRedraw();
}

void TradingPanel::Click_IncreaseTP(void){
   mTP += 1;//_Point;
   mTP_input.Text(DoubleToString(mTP,1));
   ChartRedraw();
}

void TradingPanel::Click_DecreaseTP(void){
   mTP -= 1;//_Point;
   mTP_input.Text(DoubleToString(mTP,1));
   ChartRedraw();
}

void TradingPanel::Click_Trailing(void){
   if(mTrailing_button.Pressed())
      mEnable_Trailing = true;
   else
      mEnable_Trailing = false;
   ChartRedraw();
}

void TradingPanel::Click_OrderBuy(void){
   mLots = StringToDouble(mLots_input.Text());
   mAmount = StringToInteger(mAmount_input.Text());
   if(mFixVolume)
      mLots = NormalizeDouble(mLots/mAmount, 2);
   for(uint i=0; i<mAmount; i++)
      mTA.OrderBuy(mLots,3,(mEnable_SL)?mSL*10:0,(mEnable_TP)?mTP*10:0);
   ChartRedraw();
}

void TradingPanel::Click_OrderCross(void){
   mLots = StringToDouble(mLots_input.Text());
   mAmount = StringToInteger(mAmount_input.Text());
   if(mFixVolume)
      mLots = NormalizeDouble(mLots/mAmount/2, 2);
   for(uint i=0; i<mAmount; i++)
      mTA.OrderCross(mLots,3,(mEnable_SL)?mSL*10:0,(mEnable_TP)?mTP*10:0,
                             (mEnable_SL)?mSL*10:0,(mEnable_TP)?mTP*10:0);
   ChartRedraw();
}

void TradingPanel::Click_OrderSell(void){
   mLots = StringToDouble(mLots_input.Text());
   mAmount = StringToInteger(mAmount_input.Text());
   if(mFixVolume)
      mLots = NormalizeDouble(mLots/mAmount, 2);
   for(uint i=0; i<mAmount;i++)
      mTA.OrderSell(mLots,3,(mEnable_SL)?mSL*10:0,(mEnable_TP)?mTP*10:0);
   ChartRedraw();
}

void TradingPanel::Click_CloseAllBuy(void){
   mTA.OrderCloseAllBuy();
   mTA.ResetLines("BUY");
   ChartRedraw();
}

void TradingPanel::Click_CloseAll(void){
   mTA.OrderCloseAll();
   mTA.ResetLines("");
   ChartRedraw();
}

void TradingPanel::Click_CloseAllSell(void){
   mTA.OrderCloseAllSell();
   mTA.ResetLines("SELL");
   ChartRedraw();
}
