import 'package:flutter/material.dart';
import 'package:funsunfront/models/funding_model.dart';

import '../services/api_funding.dart';

class FundingsProvider extends ChangeNotifier {
  Future<List<FundingModel>>? _myFundings;
  Future<List<FundingModel>>? get myFundings => _myFundings;

  Future<List<FundingModel>>? _joinedFundings;
  Future<List<FundingModel>>? get joinedFundings => _joinedFundings;

  Future<List<FundingModel>>? _publicFundings;
  Future<List<FundingModel>>? get publicFundings => _publicFundings;

  Future<List<FundingModel>>? _friendFundings;
  Future<List<FundingModel>>? get friendFundings => _friendFundings;

  Future<FundingModel>? _fundingDetail;
  Future<FundingModel>? get fundingDetail => _fundingDetail;

  void getMyfundings(String uid) {
    _myFundings = Funding.getUserFunding(page: '1', id: uid);
    notifyListeners();
  }

  void getJoinedfundings() {
    _joinedFundings = Funding.getJoinedFunding(page: '1');
    notifyListeners();
  }

  void getPublicFundings() {
    _publicFundings = Funding.getPublicFunding(page: '1');
    notifyListeners();
  }

  void getFriendFundings() {
    _friendFundings = Funding.getFriendFunding(page: '1');
    notifyListeners();
  }

  void refreshAllFundings(String uid) {
    _myFundings = Funding.getUserFunding(page: '1', id: uid);
    _joinedFundings = Funding.getJoinedFunding(page: '1');
    _publicFundings = Funding.getPublicFunding(page: '1');
    _friendFundings = Funding.getFriendFunding(page: '1');
    notifyListeners();
  }

  void getFundingDetail(String id) {
    _fundingDetail = Funding.getFunding(id: id);
    notifyListeners();
  }
}
