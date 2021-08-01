// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `SKIP`
  String get skip {
    return Intl.message(
      'SKIP',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `CURRENT ORDER`
  String get currentOrder {
    return Intl.message(
      'CURRENT ORDER',
      name: 'currentOrder',
      desc: '',
      args: [],
    );
  }

  /// `POSTPONED`
  String get postponed {
    return Intl.message(
      'POSTPONED',
      name: 'postponed',
      desc: '',
      args: [],
    );
  }

  /// `PRODUCTS IN THE SHOPPING CART`
  String get productsInCart {
    return Intl.message(
      'PRODUCTS IN THE SHOPPING CART',
      name: 'productsInCart',
      desc: '',
      args: [],
    );
  }

  /// `Recommended products`
  String get recommendedProducts {
    return Intl.message(
      'Recommended products',
      name: 'recommendedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Move an order to deferred`
  String get moveOrderToDeferred {
    return Intl.message(
      'Move an order to deferred',
      name: 'moveOrderToDeferred',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get cleanProductCart {
    return Intl.message(
      'Clear',
      name: 'cleanProductCart',
      desc: '',
      args: [],
    );
  }

  /// `Cart is empty`
  String get emptyCart {
    return Intl.message(
      'Cart is empty',
      name: 'emptyCart',
      desc: '',
      args: [],
    );
  }

  /// `You can add products to the cart from the catalog.`
  String get emptyCartText {
    return Intl.message(
      'You can add products to the cart from the catalog.',
      name: 'emptyCartText',
      desc: '',
      args: [],
    );
  }

  /// `Transfer products to an order`
  String get transferProductsToOrder {
    return Intl.message(
      'Transfer products to an order',
      name: 'transferProductsToOrder',
      desc: '',
      args: [],
    );
  }

  /// `Delete a list`
  String get deleteList {
    return Intl.message(
      'Delete a list',
      name: 'deleteList',
      desc: '',
      args: [],
    );
  }

  /// `There are no deferred items`
  String get noDeferredItems {
    return Intl.message(
      'There are no deferred items',
      name: 'noDeferredItems',
      desc: '',
      args: [],
    );
  }

  /// `So far, you have not postponed one product`
  String get noDeferredItemsText {
    return Intl.message(
      'So far, you have not postponed one product',
      name: 'noDeferredItemsText',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get next {
    return Intl.message(
      'CONTINUE',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Please log in before you send the order!`
  String get pleaseLog {
    return Intl.message(
      'Please log in before you send the order!',
      name: 'pleaseLog',
      desc: '',
      args: [],
    );
  }

  /// `Product catalog`
  String get productCatalog {
    return Intl.message(
      'Product catalog',
      name: 'productCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get showAll {
    return Intl.message(
      'Show all',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `The operators ' working hours are from 9: 00 to 21: 00. At other times, you can leave a voice message.`
  String get feedbackText {
    return Intl.message(
      'The operators \' working hours are from 9: 00 to 21: 00. At other times, you can leave a voice message.',
      name: 'feedbackText',
      desc: '',
      args: [],
    );
  }

  /// `A letter to technical support`
  String get letterToTechSupport {
    return Intl.message(
      'A letter to technical support',
      name: 'letterToTechSupport',
      desc: '',
      args: [],
    );
  }

  /// `Your message has been sent`
  String get messageSent {
    return Intl.message(
      'Your message has been sent',
      name: 'messageSent',
      desc: '',
      args: [],
    );
  }

  /// `Name *`
  String get requiredName {
    return Intl.message(
      'Name *',
      name: 'requiredName',
      desc: '',
      args: [],
    );
  }

  /// `Subject *`
  String get requiredSubject {
    return Intl.message(
      'Subject *',
      name: 'requiredSubject',
      desc: '',
      args: [],
    );
  }

  /// `Message *`
  String get requiredMessage {
    return Intl.message(
      'Message *',
      name: 'requiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the field`
  String get fieldRequired {
    return Intl.message(
      'Fill in the field',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email Address`
  String get emailNotValid {
    return Intl.message(
      'Invalid Email Address',
      name: 'emailNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Login / Registration`
  String get loginRegistration {
    return Intl.message(
      'Login / Registration',
      name: 'loginRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Catalog and search`
  String get catalogAndSearch {
    return Intl.message(
      'Catalog and search',
      name: 'catalogAndSearch',
      desc: '',
      args: [],
    );
  }

  /// `My orders`
  String get myOrders {
    return Intl.message(
      'My orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get info {
    return Intl.message(
      'Information',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Special offers`
  String get specialOffers {
    return Intl.message(
      'Special offers',
      name: 'specialOffers',
      desc: '',
      args: [],
    );
  }

  /// `All collections`
  String get allCollections {
    return Intl.message(
      'All collections',
      name: 'allCollections',
      desc: '',
      args: [],
    );
  }

  /// `Delicious price`
  String get deliciousPrice {
    return Intl.message(
      'Delicious price',
      name: 'deliciousPrice',
      desc: '',
      args: [],
    );
  }

  /// `New products`
  String get newProducts {
    return Intl.message(
      'New products',
      name: 'newProducts',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get offer {
    return Intl.message(
      'Offer',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data Protection and Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Personal Data Protection and Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Authorization`
  String get authorization {
    return Intl.message(
      'Authorization',
      name: 'authorization',
      desc: '',
      args: [],
    );
  }

  /// `Password *`
  String get password {
    return Intl.message(
      'Password *',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `The list of orders is empty`
  String get emptyOrders {
    return Intl.message(
      'The list of orders is empty',
      name: 'emptyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Order #`
  String get nOrder {
    return Intl.message(
      'Order #',
      name: 'nOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order ID:`
  String get orderId {
    return Intl.message(
      'Order ID:',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Created at:`
  String get createdAt {
    return Intl.message(
      'Created at:',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Client:`
  String get client {
    return Intl.message(
      'Client:',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Status:`
  String get status {
    return Intl.message(
      'Status:',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Total:`
  String get total {
    return Intl.message(
      'Total:',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Products list`
  String get productsList {
    return Intl.message(
      'Products list',
      name: 'productsList',
      desc: '',
      args: [],
    );
  }

  /// `piece`
  String get piece {
    return Intl.message(
      'piece',
      name: 'piece',
      desc: '',
      args: [],
    );
  }

  /// `Making and order`
  String get makingAnOrder {
    return Intl.message(
      'Making and order',
      name: 'makingAnOrder',
      desc: '',
      args: [],
    );
  }

  /// `Enter the delivery address`
  String get enterDeliveryAddress {
    return Intl.message(
      'Enter the delivery address',
      name: 'enterDeliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your contacts`
  String get yourContacts {
    return Intl.message(
      'Your contacts',
      name: 'yourContacts',
      desc: '',
      args: [],
    );
  }

  /// `Enter your contacts`
  String get enterYourContacts {
    return Intl.message(
      'Enter your contacts',
      name: 'enterYourContacts',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Method`
  String get deliveryMethod {
    return Intl.message(
      'Delivery Method',
      name: 'deliveryMethod',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Comment on the order`
  String get commentOnTheOrder {
    return Intl.message(
      'Comment on the order',
      name: 'commentOnTheOrder',
      desc: '',
      args: [],
    );
  }

  /// `You can leave a comment on the order`
  String get canLeaveComment {
    return Intl.message(
      'You can leave a comment on the order',
      name: 'canLeaveComment',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Payment in cash`
  String get paymentInCash {
    return Intl.message(
      'Payment in cash',
      name: 'paymentInCash',
      desc: '',
      args: [],
    );
  }

  /// `Payment online`
  String get paymentOnline {
    return Intl.message(
      'Payment online',
      name: 'paymentOnline',
      desc: '',
      args: [],
    );
  }

  /// `Payment via payme, click`
  String get paymentViaPaymeClick {
    return Intl.message(
      'Payment via payme, click',
      name: 'paymentViaPaymeClick',
      desc: '',
      args: [],
    );
  }

  /// `by Card`
  String get byCard {
    return Intl.message(
      'by Card',
      name: 'byCard',
      desc: '',
      args: [],
    );
  }

  /// `Payment via card`
  String get paymentViaCard {
    return Intl.message(
      'Payment via card',
      name: 'paymentViaCard',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Full name *`
  String get fullName {
    return Intl.message(
      'Full name *',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone number *`
  String get phoneNumber {
    return Intl.message(
      'Phone number *',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `About product`
  String get aboutProduct {
    return Intl.message(
      'About product',
      name: 'aboutProduct',
      desc: '',
      args: [],
    );
  }

  /// `Next to it on the shelf`
  String get nextToShelf {
    return Intl.message(
      'Next to it on the shelf',
      name: 'nextToShelf',
      desc: '',
      args: [],
    );
  }

  /// `Add to card`
  String get addToCard {
    return Intl.message(
      'Add to card',
      name: 'addToCard',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Product not found`
  String get productNotFound {
    return Intl.message(
      'Product not found',
      name: 'productNotFound',
      desc: '',
      args: [],
    );
  }

  /// `There are no products in this category`
  String get categoryEmpty {
    return Intl.message(
      'There are no products in this category',
      name: 'categoryEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Name *`
  String get name {
    return Intl.message(
      'Name *',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name *`
  String get lastName {
    return Intl.message(
      'Last Name *',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for ordering!`
  String get thankYouForOrdering {
    return Intl.message(
      'Thank you for ordering!',
      name: 'thankYouForOrdering',
      desc: '',
      args: [],
    );
  }

  /// `Expect our manager to contact you soon.`
  String get wait {
    return Intl.message(
      'Expect our manager to contact you soon.',
      name: 'wait',
      desc: '',
      args: [],
    );
  }

  /// `Back to homepage`
  String get goHome {
    return Intl.message(
      'Back to homepage',
      name: 'goHome',
      desc: '',
      args: [],
    );
  }

  /// `Code confirmation`
  String get codeConfirmation {
    return Intl.message(
      'Code confirmation',
      name: 'codeConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `We sent you an SMS with a confirmation code to the number ${phone}\n Please enter the code`
  String smsSent(Object phone) {
    return Intl.message(
      'We sent you an SMS with a confirmation code to the number \$$phone\n Please enter the code',
      name: 'smsSent',
      desc: '',
      args: [phone],
    );
  }

  /// `show`
  String get showMore {
    return Intl.message(
      'show',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Postpone`
  String get postpone {
    return Intl.message(
      'Postpone',
      name: 'postpone',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Enter the quantity`
  String get enterQuantity {
    return Intl.message(
      'Enter the quantity',
      name: 'enterQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Qty: `
  String get qty {
    return Intl.message(
      'Qty: ',
      name: 'qty',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Recent requests`
  String get recentRequests {
    return Intl.message(
      'Recent requests',
      name: 'recentRequests',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get byPopularity {
    return Intl.message(
      'Popular',
      name: 'byPopularity',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetically (A-Z)`
  String get alphaAZ {
    return Intl.message(
      'Alphabetically (A-Z)',
      name: 'alphaAZ',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetically (Z-A)`
  String get alphaZA {
    return Intl.message(
      'Alphabetically (Z-A)',
      name: 'alphaZA',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}