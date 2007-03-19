From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Mon, 19 Mar 2007 11:14:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191025430.3794@xena.cft.ca.us>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu> 
	<1174008860.3397.9.camel@raven.themaw.net>
	<45FA996D.2080606@redhat.com> 
	<1174055083.3397.11.camel@raven.themaw.net>
	<45FAABA3.8060608@redhat.com> 
	<x494polck3t.fsf@segfault.boston.devel.redhat.com>
	<45FAB4B8.7060908@soe.ucsc.edu>
	<1174062776.3397.51.camel@raven.themaw.net>
	<Pine.LNX.4.64.0703160951030.11089@simba.math.ucla.edu>
	<1174066773.3397.76.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1174066773.3397.76.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Sat, 17 Mar 2007, Ian Kent wrote:

> On Fri, 2007-03-16 at 10:09 -0700, Jim Carter wrote:
> ...
> > Yes, this does clear it up.  Autofs' philosophy differs from other 
> > nsswitchable maps, where a key is looked for in potentially every listed 
> > data source until found.  Whereas, autofs identifies the first map that 
> > exists, and looks up a key in that map, and if it's absent, you lose.  It 
> > doesn't go on to look for the key in subsequent data sources such as LDAP, 
> > unless the plus kludge has been used.  (In any case, the first found 
> > instance of the key is used and subsequent instances or sources are 
> > not looked at.)
> 
> Maybe I have got this wrong then.
> 
> I thought the default nsswitch action was [NOTFOUND=continue] so autofs
> will search multiple source instances of a given map name for a key and
> the first match will succeed or not found will be returned. This is so
> only if the map source is not explicitly given in the map name in which
> case only that map source will be consulted.

That's how I think it "should" be and that's how it will come out if you 
use the Gnu libc subroutines.  But that's not what you said and neither is 
it what Jeff Moyer said.  

The autofs-5 behavior appears to be as if the line in nsswitch.conf said
"autofs: files [notfound=return] nis/ldap" (nis or ldap, whichever is 
configured).  According to the original person posting, he formerly got the 
effect of "autofs: files ldap" (with the default [notfound=continue]) and 
doesn't get it now.  (I think I understood him.)  Hence my sniping about 
out-of-the-box Solaris compatibility and breaking Linux upon upgrade.

nsswitch is really confusing because there are two items being sought: 
first the map, and second the key within the map.  The notfound reaction 
tag refers to not finding the key in a working map, while unavail is for 
not finding the map at all.

Maybe the thing to do now is to get into cold print some positive 
statements, and perhaps the nsswitch.conf syntax is the way to express it:

What does Solaris do?  "autofs: files [notfound=return] nis", except with a
plus at the end of the map it ends up as "autofs: files [notfound=continue] 
nis".  In either case, [unavail=continue].  (Jeff, did I get it right?)

What does Linux autofs-5 do?  The same thing, right?  

What does Linux autofs-4 do?  

What *should* Linux autofs-5 do?  Jeff makes some good points that the 
answer should be "imitate Solaris".  Cross vendors, we need to pick a
standard that works in most cases, and to stick with it.

And which of these actually obey an autofs line in /etc/nsswitch.conf if 
one is present?  I hope the answer is "all of them", which would provide a 
neat fix for the original complaining user.  If someone has a special 
circumstance, it's really valuable to be able to replace the default 
behavior in this way.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
