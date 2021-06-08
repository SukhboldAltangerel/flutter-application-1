String? getPathName(path, index) {
  List pathNamesList = path.split('/');
  pathNamesList.removeWhere((pathName) => pathName == '');
  pathNamesList = pathNamesList.map((pathName) => '/' + pathName).toList();
  if (pathNamesList.length > index) {
    return pathNamesList[index];
  } else {
    return null;
  }
}
