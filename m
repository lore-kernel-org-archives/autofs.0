From: Jim Carter <jimc@math.ucla.edu>
Subject: Request for Sun-like hosts map
Date: Thu, 4 Mar 2004 11:32:59 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403040933220.2698@simba.math.ucla.edu>
References: <16452.51314.769206.991484@segfault.boston.redhat.com> 
 <Pine.LNX.4.58.0403031455220.16583@wombat.indigo.net.au> 
 <16453.61187.553910.939557@segfault.boston.redhat.com> 
 <Pine.LNX.4.58.0403041224300.7374@wombat.indigo.net.au> 
 <1078409214.29340.33.camel@brilong-lnx2.cisco.com> 
 <Pine.LNX.4.58.0403042231270.4704@raven.themaw.net>
 <1078415161.2236.10.camel@brilong-lnx2.cisco.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1078415161.2236.10.camel@brilong-lnx2.cisco.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

While we're discussing features that people would like:  Here at
UCLA-Mathnet we have over 100 machines which export various filesystems to
random other machines on an "as needed" basis.  On Solaris,
/etc/auto_master includes a line:

/net            -hosts          -nosuid,nobrowse

which means that if a user refers to /net/tupelo/h1/maint/jimc (for 
example), the toplevel automounter process will fork a submount for 
/net/tupelo, and that one will attempt to mount tupelo:/h1.  

To emulate this on Linux, I do (or the startup script does) "automount /net 
program /etc/auto.net", where the program map is a cockamamie script I 
wrote which creates a map file saying

*       tupelo:/&

in a special directory, and then exudes 

-rsize=8192,wsize=8192,retry=1,soft,fstype=autofs file:/rete/tupelo

so that the submount will get the newly created map file.  It also purges 
map files that are no longer in use.  This latter part is nasty and risky.

Automating this script would be really nice.  In the current Sun approach,
the whole thing is just assumed for a host map.  Here's a somewhat more
configurable proposal for Linux:

There would be a new map type of, well, what's a reasonable name for it?  
"macro".  The second field of the map row would be "macro:(the literal
content of the map)", as if read from a file.  Since it contains
whitespace, it must be enclosed in (parens).  (Not quotes, because you need
nested quoting, and it's too hard to determine the polarity of imbedded
quotes.)

Backslash should escape any character, in the sense that backslash-anything
(except newline?) turns into the "anything" character and magic semantics
is bypassed.  In particular, & and $ and a second backslash would have
their magic concealed.  To have a control character interpreted at the n-th
level you need (2^n)-1 backslashes.  (Since parens are nested, it doesn't
matter whether you put backslashes on them or not.)

For example, the host map could be represented in /etc/auto.master as:

    /net macro:(* macro:(* &:/\&)) -fstype=autofs,other_options

Upon access to /net/tgthost/filesys, the first ampersand is expanded to the 
toplevel key (target host name), producing a submount, which thinks its map 
file says:

    * macro:(* tgthost:/&) -other_options

Then when the submount sees the request it expands its macro into a map
line like this, with & replaced by the key from the request:

    * tgthost:/filesys -other_options

which is exactly what you need to get the job done.

Since lines can get long in automount maps, particularly macro lines, and
since we have to work on backslashes anyway, this might be a nice time to
put in backslash-newline escapes.  The rule would be to completely ignore
backslash-newline-whitespace.  If you want whitespace there, put a blank 
before \\n.  For example,

    key type:long_bunch_of_stuff \\n
	mount_options
    key type:more_prolix\\n
	_stuff mount_options

would be equivalent to

    key type:long_bunch_of_stuff mount_options
    key type:more_prolix_stuff mount_options

What do you think?  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
