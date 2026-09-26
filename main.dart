import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main()=>runApp(const NigerAideApp());

class NigerAideApp extends StatelessWidget{
 const NigerAideApp({super.key});
 Widget build(BuildContext c)=>MaterialApp(
  debugShowCheckedModeBanner:false,title:'NIGER AIDE',
  theme:ThemeData(colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFF008751)),useMaterial3:true),
  home:const Home());
}

class Pro{
 final String name,job,city,phone; final bool vip;
 const Pro({required this.name,required this.job,required this.city,required this.phone,this.vip=false});
}

class Home extends StatefulWidget{const Home({super.key});State<Home> createState()=>_Home();}
class _Home extends State<Home>{
 String cat='Tout';
 final cats=['Tout','Mécanicien','Plombier','Électricien','Menuisier','Chauffeur','Maçon','Couturier','Coiffeur','Peintre','Jardinier','Frigoriste','Informaticien'];
 final pros=const[
  Pro(name:'Ibrahim Salissou',job:'Mécanicien',city:'Niamey',phone:'98222703',vip:true),
  Pro(name:'Moustapha Garba',job:'Plombier',city:'Zinder',phone:'90000000',vip:true),
  Pro(name:'Aliyu Oumarou',job:'Électricien',city:'Maradi',phone:'91111111'),
  Pro(name:'Amina Souley',job:'Couturier',city:'Niamey',phone:'92222222',vip:true)];
 Future<void> call(String n)async{final u=Uri(scheme:'tel',path:n);if(await canLaunchUrl(u))await launchUrl(u);}
 Widget build(BuildContext c){
  final list=cat=='Tout'?pros:pros.where((p)=>p.job==cat).toList();
  return Scaffold(appBar:AppBar(title:const Text('🇳🇪 NIGER AIDE'),backgroundColor:const Color(0xFF008751),foregroundColor:Colors.white),
   drawer:Drawer(child:ListView(children:[
    const DrawerHeader(decoration:BoxDecoration(color:Color(0xFF008751)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[CircleAvatar(radius:28,backgroundColor:Colors.white,child:Icon(Icons.handshake,color:Color(0xFF008751))),SizedBox(height:8),Text('NIGER AIDE',style:TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.bold))])),
    ListTile(leading:const Icon(Icons.person_add),title:const Text('Je suis professionnel'),onTap:(){Navigator.pop(c);Navigator.push(c,MaterialPageRoute(builder:(_)=>const ProForm()));}),
    ListTile(leading:const Icon(Icons.star,color:Colors.amber),title:const Text('Devenir VIP'),onTap:(){Navigator.pop(c);Navigator.push(c,MaterialPageRoute(builder:(_)=>const Vip()));})
   ])),
   body:Column(children:[
    Container(margin:const EdgeInsets.all(12),padding:const EdgeInsets.all(16),width:double.infinity,decoration:BoxDecoration(color:const Color(0xFF008751),borderRadius:BorderRadius.circular(15)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Trouvez un professionnel près de chez vous',style:TextStyle(color:Colors.white,fontSize:18,fontWeight:FontWeight.bold)),SizedBox(height:5),Text('Métiers • Photos • Vidéos • Contact direct',style:TextStyle(color:Colors.white70))])),
    SizedBox(height:50,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:cats.length,itemBuilder:(_,i)=>Padding(padding:const EdgeInsets.symmetric(horizontal:4),child:ChoiceChip(label:Text(cats[i]),selected:cat==cats[i],onSelected:(_)=>setState(()=>cat=cats[i]))))),
    const Divider(),Expanded(child:ListView.builder(itemCount:list.length,itemBuilder:(_,i){final p=list[i];return Card(margin:const EdgeInsets.symmetric(horizontal:12,vertical:5),child:ListTile(
     onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Profile(p:p,onCall:()=>call(p.phone)))),
     leading:CircleAvatar(child:Icon(p.vip?Icons.star:Icons.person)),
     title:Row(children:[Flexible(child:Text(p.name,style:const TextStyle(fontWeight:FontWeight.bold))),if(p.vip)const Icon(Icons.verified,color:Colors.blue,size:17)]),
     subtitle:Text('${p.job} • ${p.city}'),trailing:IconButton(icon:const Icon(Icons.call,color:Color(0xFF008751)),onPressed:()=>call(p.phone))));}))
   ]));
 }
}

class Profile extends StatelessWidget{
 final Pro p;final VoidCallback onCall;const Profile({super.key,required this.p,required this.onCall});
 Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text(p.name),backgroundColor:const Color(0xFF008751),foregroundColor:Colors.white),body:ListView(padding:const EdgeInsets.all(16),children:[
  const CircleAvatar(radius:48,child:Icon(Icons.person,size:50)),const SizedBox(height:10),
  Center(child:Text(p.name,style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold))),Center(child:Text('${p.job} • ${p.city}')),
  if(p.vip)const Center(child:Chip(avatar:Icon(Icons.verified),label:Text('MEMBRE VIP'))),
  const SizedBox(height:20),const Text('Photos de mes travaux',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
  const SizedBox(height:8),Container(height:130,color:Colors.black12,child:const Center(child:Text('Les photos du professionnel apparaîtront ici.'))),
  const SizedBox(height:20),const Text('Vidéo de mon travail',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
  const SizedBox(height:8),Container(height:130,color:Colors.black12,child:const Center(child:Text('La vidéo apparaîtra ici.'))),
  const SizedBox(height:20),SizedBox(height:50,child:ElevatedButton.icon(onPressed:onCall,icon:const Icon(Icons.call),label:const Text('Appeler')))
 ]));
}

class ProForm extends StatefulWidget{const ProForm({super.key});State<ProForm> createState()=>_ProForm();}
class _ProForm extends State<ProForm>{
 final name=TextEditingController(),city=TextEditingController(),phone=TextEditingController();String job='Mécanicien';final picker=ImagePicker();int photos=0;bool video=false;
 Future<void> photo()async{final x=await picker.pickImage(source:ImageSource.gallery);if(x!=null)setState(()=>photos++);}
 Future<void> vid()async{final x=await picker.pickVideo(source:ImageSource.gallery);if(x!=null)setState(()=>video=true);}
 Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Créer mon profil'),backgroundColor:const Color(0xFF008751),foregroundColor:Colors.white),body:ListView(padding:const EdgeInsets.all(16),children:[
  TextField(controller:name,decoration:const InputDecoration(labelText:'Nom complet',border:OutlineInputBorder())),const SizedBox(height:12),
  TextField(controller:city,decoration:const InputDecoration(labelText:'Ville',border:OutlineInputBorder())),const SizedBox(height:12),
  TextField(controller:phone,decoration:const InputDecoration(labelText:'Téléphone',border:OutlineInputBorder())),const SizedBox(height:12),
  DropdownButtonFormField(value:job,decoration:const InputDecoration(labelText:'Métier',border:OutlineInputBorder()),items:['Mécanicien','Plombier','Électricien','Menuisier','Chauffeur','Maçon','Couturier','Coiffeur','Peintre','Jardinier','Frigoriste','Informaticien'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(x)=>setState(()=>job=x!)),
  const SizedBox(height:15),Row(children:[Expanded(child:OutlinedButton.icon(onPressed:photo,icon:const Icon(Icons.photo),label:const Text('Photo'))),const SizedBox(width:8),Expanded(child:OutlinedButton.icon(onPressed:vid,icon:const Icon(Icons.video_library),label:const Text('Vidéo')))]),
  const SizedBox(height:8),Text('$photos photo(s) • ${video?'1 vidéo':'babu video'}'),const SizedBox(height:18),
  ElevatedButton(onPressed:()=>showDialog(context:c,builder:(_)=>const AlertDialog(title:Text('Kusan!'),content:Text('An shirya bayanan. Domin su zama online, mataki na gaba shi ne haɗa Firebase database da Storage.'))),child:const Text('Publier mon profil'))
 ]));
}

class Vip extends StatelessWidget{const Vip({super.key});Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('VIP'),backgroundColor:const Color(0xFF008751),foregroundColor:Colors.white),body:Padding(padding:const EdgeInsets.all(20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
 const Icon(Icons.workspace_premium,color:Colors.amber,size:60),const SizedBox(height:10),const Text('VIP — 300 FCFA / 2 mois',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
 const SizedBox(height:10),const Text('Airtel Money: 98222703'),const SizedBox(height:15),const TextField(decoration:InputDecoration(labelText:'Référence de transaction',border:OutlineInputBorder())),
 const SizedBox(height:15),SizedBox(width:double.infinity,height:50,child:ElevatedButton(onPressed:()=>ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('Ana jiran tabbatar da biyan kuɗi.'))),child:const Text('Aika don tabbatarwa')))
 ]));}
