
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorsGameApp extends StatefulWidget {
  @override
  _ColorsGameAppState createState() => _ColorsGameAppState();
}

class _ColorsGameAppState extends State<ColorsGameApp> {
  int _currentQuestion=0;
  int _currentscore=0;
  _onoptionclicked(bool iscorrectanswer)
  {if(iscorrectanswer)
   ++ _currentscore;
    setState(() {
      ++_currentQuestion;
    });}
  _PlayAgain()
  {
    setState(() {
      _currentQuestion=0;
      _currentscore=0;
    });

  }

    List<Question> question=[Question('أحمر',Colors.green ,[Options('أحمر'),Options('ازرق'),Options('اخضر',true),Options('برتقالي'),Options('اصفر'),Options('اسود')]),
      Question('ازرق',Colors.red,[Options('أحمر',true),Options('ازرق'),Options('اخضر'),Options('برتقالي'),Options('اصفر'),Options('اسود')]),
      Question('اخضر',Colors.blue, [Options('أحمر'),Options('ازرق',true),Options('اخضر'),Options('برتقالي'),Options('اصفر'),Options('اسود')]),
      Question('برتقالي',Colors.black,[Options('أحمر'),Options('ازرق'),Options('اخضر'),Options('برتقالي'),Options('اصفر'),Options('اسود',true)]),
      Question('اصفر',Colors.orange,[Options('أحمر'),Options('ازرق'),Options('اخضر'),Options('برتقالي',true),Options('اصفر'),Options('اسود')]),
      Question('اسود',Colors.yellow,[Options('أحمر'),Options('ازرق'),Options('اخضر'),Options('برتقالي'),Options('اصفر',true),Options('اسود')])
    ];




  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //  when to much option add to list and then let auto convert to widget
    List<Widget> optinWidget=[];
    if(_currentQuestion<question.length)
      optinWidget= (question[_currentQuestion].options).map((option) {

      return OptionWidget(option,_onoptionclicked);
    }).toList();
    optinWidget.shuffle();
    return Scaffold(
      appBar: AppBar(title: Center (child:Text('لعبة الالوان'), )),
      body:_currentQuestion<question.length ?
      Column(
        children: <Widget>[
          //same space tag  in android
          //SizedBox(height: 20,),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text('اختر لون الكلمة التالية',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)
          )
          ,

          QuestionText(question[_currentQuestion].title,question[_currentQuestion].color),

          //Expanded
          Flexible(

            child: GridView.count(crossAxisCount: 3,children: optinWidget,) ,)



        ],

      )  : EndPage(_currentscore,question.length,_PlayAgain )
      ,
    );

  }

  @override
  void initState() {
    //first time in create
  }
  }

//specific widget
class QuestionText extends StatelessWidget {
  final String title;
  final Color textcolor;

  const QuestionText(this.title,this.textcolor,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('$title',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:textcolor) );
  }
}
class OptionWidget extends StatelessWidget {
  final Options option;
  final Function(bool) onclick;
  const OptionWidget(this.option,this.onclick,{Key key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //make everything clicable
   // GestureDetector(onTap: ,child: ,)
  
   
    return InkWell(
      onTap:(){
        onclick(option.iscorrectanswer);
      }
      , child: Container(
        margin: EdgeInsets.fromLTRB(3,3, 3, 3),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(option.text,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white,backgroundColor: Colors.blue) ),
        color:Colors.blue
        ,
        alignment: Alignment.center
        ));




    }}
class Question{
  final String title;
  final Color color ;
 final  List<Options> options;

  Question(this.title,this.color, this.options, );


}
class Options{
  final String text;
 final bool iscorrectanswer;
  Options(this.text,[this.iscorrectanswer=false] );


}
class  EndPage extends StatelessWidget {
  final int currentscore;
  final int questionsize;
final Function playagain;
  const EndPage(this.currentscore, this.questionsize,this.playagain, {Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon _icon =Icon(Icons.error);
    String _resultmessage='All Answer Is Wrong';
    if(currentscore==0){
       _icon =Icon(Icons.error,color: Colors.red,size:70 ,);
       _resultmessage='جميع اجاباتك خاطئة ';
    }
     if (currentscore<3){
      _icon =Icon(Icons.cancel,color: Colors.red,size:70 );
      _resultmessage='حظا اوفر';

    }
     if (currentscore==3){
      _icon =Icon(Icons.brightness_medium,color: Colors.yellow,size:70 );
      _resultmessage='لقد نجحت فقط';

    }
     if (currentscore==6){
      _icon =Icon(Icons.check,color: Colors.green,size:70 );
      _resultmessage='ممتاز كل الاجابات صحيحة ';

    }
     if (currentscore==4||currentscore==5){
      _icon =Icon(Icons.check_circle_outline,color: Colors.yellow,size:70 );
      _resultmessage='جيد لكن بعض الاجابات خاطئة';

    }
    return Center(
      child: Container(child: Column(
        children: <Widget>[
        _icon,

        Text(' انتهت العبة',style: TextStyle(fontSize: 20),),
        Text('$_resultmessage $currentscore/$questionsize',style: TextStyle(fontSize: 20,color: Colors.blue)),
RaisedButton(onPressed: playagain,child: Text('اعد العبة '),)
      ],),),
    );
  }
}

