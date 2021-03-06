import 'package:emplog/model/db/attendance.dart';
import 'package:emplog/model/outlet.dart';
import 'package:emplog/model/shop.dart';

double fakeLatitude = 23.874187586642176;
double fakeLongitude = 90.40443741117636;

List<Outlet> outlets = [
  Outlet(
      guid: "o1",
      branch: "প্রগতি সরনী",
      branchType: "Jamuna Electronics Showroom",
      address: "193 প্রগতি সরনী, ঢাকা 1229",
      logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYCpR-NGr1fIUtcJ36spbE49T9MRFE3Qnt3w&usqp=CAU",
      latitude: 23.8130958,
      longitude: 90.4211896,
      contactPerson: "Jamil Sorwer",
      phone: "01777-778595"),
  Outlet(
      guid: "o2",
      branch: "Jamuna Future Park",
      branchType: "Jamuna Electronics & Automobiles Limited",
      address: "Ka-244, Progoti Soroni Kuril Jamuna Future Park 6th Flor, Dhaka 1229",
      logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGrKxS_3XyI7QhdFyyZM0qRalJVUj33_VJUQ&usqp=CAU",
      latitude: 23.8134905,
      longitude: 90.3891376,
      contactPerson: "Rashid Ahmed",
      phone: ""),
  Outlet(
      guid: "o3",
      branch: "টঙ্গী",
      branchType: "Jamuna Electronics & Automobiles",
      address: "Tongi",
      logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYCpR-NGr1fIUtcJ36spbE49T9MRFE3Qnt3w&usqp=CAU",
      latitude: 23.8996512,
      longitude: 90.4071998,
      contactPerson: "Shafik Bari",
      phone: "+8801911707591"),
  Outlet(
      guid: "o4",
      branch: "Gazipur",
      branchType: "Jamuna Electronics Gazipur Plaza",
      address: "Gazipur",
      logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGrKxS_3XyI7QhdFyyZM0qRalJVUj33_VJUQ&usqp=CAU",
      latitude: 23.8769384,
      longitude: 90.3889525,
      contactPerson: "Ahmed Malik",
      phone: "+8801766694341"),
  Outlet(
      guid: "o5",
      branch: "Pallabi",
      branchType: "Jamuna Showroom",
      address: "Sujat Mansion, Pallabi, Mirpur 12, Dhaka 1216",
      logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYCpR-NGr1fIUtcJ36spbE49T9MRFE3Qnt3w&usqp=CAU",
      latitude: 23.8295041,
      longitude: 90.3700761,
      contactPerson: "Kiron Patowary",
      phone: ""),
  Outlet(
      guid: "o6",
      branch: "PIISTECH",
      branchType: "Jamuna Software Division",
      address: "House#44, Road#1, Uttara 6, Dhaka 1230",
      logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGrKxS_3XyI7QhdFyyZM0qRalJVUj33_VJUQ&usqp=CAU",
      latitude: 23.874187586642176,
      longitude: 90.40443741117636,
      contactPerson: "Parves Kawser",
      phone: "01814526437"),
];

List<Attendance> attendances = [
  Attendance(
      guid: "a1", dateTime: "2021-03-03 20:01:00", latitude: fakeLatitude, longitude: fakeLongitude, location: "প্রগতি সরনী", event: "Out", duration: "10 hours", picture: ""),
  Attendance(
      guid: "a2",
      dateTime: "2021-03-03 18:22:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "Vai Vai store",
      event: "ShopVisit",
      duration: "10 hours",
      picture: ""),
  Attendance(
      guid: "a3",
      dateTime: "2021-03-03 13:42:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "General Electronic store",
      event: "ShopVisit",
      duration: "10 hours",
      picture: ""),
  Attendance(
      guid: "a4",
      dateTime: "2021-03-03 11:07:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "Akib Electronic heaven",
      event: "ShopVisit",
      duration: "10 hours",
      picture: ""),
  Attendance(
      guid: "a5",
      dateTime: "2021-03-03 08:02:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "Jamuna Future Park Outlet",
      event: "In",
      duration: "10 hours",
      picture: ""),
  Attendance(
      guid: "6", dateTime: "2021-03-02 19:51:00", latitude: fakeLatitude, longitude: fakeLongitude, location: "প্রগতি সরনী", event: "Out", duration: "09 hours", picture: ""),
  Attendance(
      guid: "a7",
      dateTime: "2021-03-02 18:22:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "Vai Vai store",
      event: "ShopVisit",
      duration: "10 hours",
      picture: ""),
  Attendance(
      guid: "a8",
      dateTime: "2021-03-02 13:42:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "General Electronic store",
      event: "ShopVisit",
      duration: "10 hours",
      picture: ""),
  Attendance(
      guid: "a9",
      dateTime: "2021-03-02 11:07:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "Akib Electronic heaven",
      event: "ShopVisit",
      duration: "10 hours",
      picture: ""),
  Attendance(
      guid: "a10",
      dateTime: "2021-03-02 10:02:00",
      latitude: fakeLatitude,
      longitude: fakeLongitude,
      location: "Jamuna Future Park Outlet",
      event: "In",
      duration: "9 hours",
      picture: ""),
];

List<Shop> shops = [
  Shop(
      guid: "s1",
      name: "Anjan's Electronics",
      logo: "https://www.mawbiz.com.bd/application/views/module/product_image/IMG_2056_1.JPG",
      address: "Faridabad, Dhaka",
      phone: "01770347583",
      contactPerson: "Anjan Shaha",
      latitude: 23.6939655,
      longitude: 90.4234688),
  Shop(
      guid: "s2",
      name: "Ashar Alo Enterprise",
      logo: "https://d1c7drk47yg0al.cloudfront.net/images/TgQZ9A7gTLayyOuXRgEC_TN0OGfSGK5IJqjSuC70A_IMGP5019.jpeg?profile=twitter.summary_card",
      address: "Jatrabari, Dhaka",
      phone: "01712170323",
      contactPerson: "Mohsin Rubel",
      latitude: 23.753472,
      longitude: 90.4063153),
  Shop(
      guid: "s3",
      name: "Electronics Garden",
      logo:
          "https://content3.jdmagicbox.com/comp/kolkata/k1/033pxx33.xx33.091102213741.w5k1/catalogue/azad-electronics-garden-reach-kolkata-electronic-goods-showrooms-1tabqfd-250.jpg",
      address: "Lalbag, Dhaka",
      phone: "01670833015",
      contactPerson: "Shorif Talukder",
      latitude: 23.7191072,
      longitude: 90.3888565),
  Shop(
      guid: "s4",
      name: "M. B. Electronics",
      logo: "https://content3.jdmagicbox.com/comp/ajmer/y2/9999px145.x145.140503170634.d7y2/catalogue/mb-electronics-ajmer-ho-ajmer-mobile-phone-dealers-dbesepa.jpg",
      address: "Lalbag, Dhaka",
      phone: "01681850775",
      contactPerson: "Mohin Bhuiyan",
      latitude: 23.7139398,
      longitude: 90.409237),
  Shop(
      guid: "s5",
      name: "RPT Electronics Mela",
      logo: "https://www.bestelectronicsltd.com/wp-content/uploads/2016/12/1-3.jpg",
      address: "Demra, Staff Quarter, Dhaka",
      phone: "01819921852",
      contactPerson: "Robiul Poddar Tuhin",
      latitude: 23.7066516,
      longitude: 90.4492991),
];

final List<String> notificationHistory = [];
