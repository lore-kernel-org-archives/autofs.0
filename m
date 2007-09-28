From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [PATCH] 5.0.0_beta1: use PATH in execXX()
Date: Fri, 28 Sep 2007 09:53:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709280935550.20980@simba.math.ucla.edu>
References: <200709261100.54397.vda.linux@googlemail.com>
	<1190970685.11447.6.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1190970685.11447.6.camel@raven.themaw.net>
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

On Fri, 28 Sep 2007, Ian Kent wrote:

> On Wed, 2007-09-26 at 11:00 +0100, Denys Vlasenko wrote:
> > I think it's reasonably safe since automount is started by root
> > and root is expected to set PATH sanely.
 --snip--
> I still can't agree that using $PATH to locate executable maps is OK.
> If a system uses executable maps then I think the location of them
> should be specified in full.

Well, in the development of autofs we started with file maps, and when 
executable maps were implemented it was natural to seem them as an 
evolution of file maps, i.e. properly found in /etc via a full path name.  
(/etc hasn't had generic executable content, like /etc/fsck, since 4.2BSD I 
believe).  However, the requester has given a plausible scenario, the same 
master map used on multiple distros with different preferred homes for 
locally hacked executable files.  Here at UCLA-Mathnet we had (in the past, 
thankfully) exactly this situation: Solaris, Irix, Ultrix and Linux at the 
same time and the same master map on all of them, although we stuck with 
the explicit path names in /etc.  (I think we may have had tweaks per OS, 
actually, which occasionally got overwritten when some bozo installed the 
master map "everwhere".)

My feeling is that programs should allow the sysop maximum flexibility for 
possibly unique situations, absent a real operational need for the more 
restrictive solution.  In other words, UNIX is supposed to let you shoot 
yourself in the foot.  So I support using execvp to exec executable maps, 
even though I definitely won't be taking advantage of the feature.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
