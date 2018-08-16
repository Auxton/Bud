Bud App
==============
This is the Bud coding challenge to fetch data and load it on a tableview


Build and Run
===========
Build using Xcode >=  8


API
===
http://www.mocky.io/v2/5b33bdb43200008f0ad1e256
https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg

Issues
=====
Api doesnt contain subtitles (e.g. Forbidden planet doesnt have an attribute for General)
Icons have white background which means the thumbnail cannot have the light grey tint.
APIs have SSL issues and icons sometimes doesnt load depending on network security.


Assumptions
==========
The monetary values uses locale for currency formatter. (Please set Region to United Kingdom to show values in pounds (£))
There is also an option to use "currency" or "currency_iso" which is not implemented.

More Implemenation
================

1. Add Reachability to reload when there's no network connection.
2. Better Unit test.
3. Active UI design.
