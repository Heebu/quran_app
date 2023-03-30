import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pages extends StatefulWidget {
  Pages({
    Key? key,
    required this.surah,
    required this.englishName,
    required this.surahs,
    required this.number,
    required this.bismiLlah,
    required this.mainColoring,
    required this.revelationType,
    required this.englishNameTranslation,
    required this.tawba,
  }) : super(key: key);
  final String surah;
  final String englishName;
  final String revelationType;
  final String englishNameTranslation;
  final List surahs;
  final String bismiLlah;
  final int number;
  final MaterialColor mainColoring;
  final bool tawba;

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  //int i = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(100.h),
                child: Container(
                  color: widget.mainColoring.shade50,
                  height: 70.h,
                  child: Center(
                    child: Text(
                      widget.tawba ? '' : widget.bismiLlah,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'AlQuranAli-L3A83',
                      ),
                    ),
                  ),
                )),
            collapsedHeight: 130.h,
            floating: true,
            backgroundColor: Colors.white,
            flexibleSpace:
                //Main Header][
                Container(
              decoration: BoxDecoration(
                  color: widget.mainColoring,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  )),
              height: 150.h,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      widget.surah,
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'AlQuranAli-L3A83',
                      ),
                    ),
                    Text(
                      widget.englishName,
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chapter ${widget.number}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${widget.englishNameTranslation}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.revelationType,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Bismillah header
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: widget.mainColoring.shade100,
                  child: Wrap(
                    //crossAxisAlignment: WrapCrossAlignment.end,
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Wrap(
                          children: [
                            //the page text
                            index == 0 && widget.tawba == false
                                ? Text(
                                    '${widget.surahs[index]['text'].toString().substring(39)}',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            'KFGQPC Uthman Taha Naskh Regular'),
                                    softWrap: true,
                                  )
                                : Text(
                                    '${widget.surahs[index]['text']}',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            'KFGQPC Uthman Taha Naskh Regular'),
                                    softWrap: true,
                                  ),

                            //numbering
                            Container(
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: widget.mainColoring,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(),
                              ),
                              child: Text(
                                '﴾${widget.surahs[index]['numberInSurah'].toString()}﴿',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        'KFGQPC Uthman Taha Naskh Regular'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //for the bottom center page
                      widget.surahs[index]['page'] <
                              widget.surahs[index + 1]['page']
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              padding: EdgeInsets.all(10),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: widget.mainColoring,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Page  ${widget.surahs[index]['page']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Juzu  ${widget.surahs[index]['juz']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Hizbu  ${widget.surahs[index]['hizbQuarter'] / 2}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
              childCount: widget.number - 1,
            ),
          ),
        ]),
      ),
    );
  }
}
