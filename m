From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Fri, 16 Mar 2007 09:25:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703160904560.11089@simba.math.ucla.edu>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>
	<1174008860.3397.9.camel@raven.themaw.net>
	<45FA996D.2080606@redhat.com>
	<1174055083.3397.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1174055083.3397.11.camel@raven.themaw.net>
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

On Fri, 16 Mar 2007, Ian Kent wrote:

> > > That's correct.
> > > That's the behavior of other industry standard automounters.
> > > Adding a plus include line at the end of /etc/auto.master (as in the
> > > default configuration) will allow the inclusion of the LDAP master map
> > > in the above example.
> > 
> > Is this really true?  My impression was that autofs implementations such as
> > the Solaris version would use the name service switch really as a switch.
> > It would look for a map following the standard rules which apply to
> > nsswitch.conf entries.  I can remember using a combination of NIS+ and
> > flat files for map sources, without having to resort to the "+" tricks.
> 
> Think so.
> I'll check again.
> But I think that the first source found (master map in this case) is
> used.

For other maps on Solaris such as passwd, if the key were not found in the 
first source (files) it would normally try the next one (NIS or, on 
advanced systems, LDAP).  According to the man page, glibc for Linux does 
the same thing.  It's possible (Solaris and Linux) to influence this 
behavior by reaction tags such as [NOTFOUND=return].  The plus kludge was a 
Solaris-ism introduced in SunOS-3.x, before nsswitch.conf.  libc::getpwnam 
etc. would always consult files first, and then if you had NIS you could 
authorize its use by appending the plus line.  But plus lines were 
deprecated when nsswitch.conf appeared, I think in SunOS-4.0.

I can't remember whether Solaris autofs followed the same rule.  

I'm inclined to say that if it didn't, it should have, and we should do it 
"right" rather than carrying forward historical mistakes for the sake of 
being able to drop a Linux kernel and packages among Solaris configuration 
files and having it work out of the box (and having it NOT work out of the 
box when a man-page-following Linux sysop upgrades).  But I can see why 
Solaris sysadmins might think differently.  Certainly plus lines should not 
be rejected noisily as errors.  Better to just ignore them.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
