From: peter.a.harris@exgate.tek.com
Subject: RE: unacceptable bug in autofs kernel module
Date: Mon, 7 Mar 2005 16:16:41 -0800
Message-ID: <C147DE5CF1A13D42B560879D6D212E63012F3B5D@us-bv-m21.global.tektronix.net>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mmarion@qualcomm.com
Cc: autofs@linux.kernel.org

Mike,

We use a mixture of direct and indirect maps, all with ghosting turned on.
The problems we are seeing are evenly spread between the two types.  Our
basic tools and home directories are indirect maps, the project data and
project specific tools are in a large direct map.  All the maps are NIS (not
NIS+) served.  All totaled we have about 1200+ mounts.

We have also seen some problems on the Solaris boxes in a timeframe similar
to our Linux problems.  We have been getting more RPC timeouts and NFS
server not responding errors in the messages files.  And the users have been
complaining of, what they have termed, "pausenia" and "stuttering".
Pausenia is where the user types a command and the shell locks for 15 to 60
seconds before anything happens.  Stuttering is a file not found error,
followed by the file being there when the user immediately (after cursing
and retyping) reissues the command.  The one difference we see on the
Solaris side is that the automounter seems to self-recover.

We have turned off the "/net" program map because there are too many
problems with things staying mounted, overly long exports lists from the
filers, etc. and we don't really need it on every machine.


Pete Harris
Central Engineering / Technical Computing
Phone:	1-503-627-3989
Fax:	1-503-627-5587

   __++__            ---------  ___,--. --+_._._:_    
  _|____|_ _________ |__|_|__| |_SP&S_| |_|_===__|    
   oo  oo ~ oo   oo ~ oo   oo ~ ooo ooo~ o OOOO =o\   
============================================================
Perform random acts of kindness and senseless beauty...

=-----Original Message-----
=From: Mike Marion [mailto:mmarion@qualcomm.com]
=Sent: Monday, March 07, 2005 11:49 AM
=To: Harris, Peter A
=Cc: autofs@linux.kernel.org
=Subject: Re: [autofs] unacceptable bug in autofs kernel module
=
=On Feb 4, 2005, at 10:58 AM, peter.a.harris@exgate.tek.com wrote:
=
=> Funny you should mention - I was just getting ready to ask about this.
=
=Curious.. those that are seeing that mount problem, especially for jobs
=submitted via a system like lsf.. What kind of map(s) are you seeing
=the problems on?  Direct map with/without ghosting?   Program map?  yp?
=ldap? etc..
=
=We've been having the problem with a shell scripted, program map to
=support our sun auto.direct map, but I did just get the newer direct
=map support with ghosting working on a couple test boxes and want to do
=some testing to see if that helps vs the non-visible way it was with
=the program script.
=
=--
=Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
=Drew: "Violence doesn't solve anything? World War I. World War II. Star
=Wars.
=every Super Bowl. Who says violence doesn't solve anything?!" ==> Drew
=Cary Show
