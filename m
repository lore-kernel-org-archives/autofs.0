From: Thomas Jahns <Thomas.Jahns@gmx.net>
Subject: Re: automount doesn't reread file map, automount
 terminates on empty file map
Date: Wed, 15 Dec 2004 21:03:34 +0000
Message-ID: <1103144614l.6934l.0l@mercury>
References: <1102796222l.6265l.2l@mercury>
	<Pine.LNX.4.58.0412151807070.30726@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412151807070.30726@wombat.indigo.net.au> (from
	raven@themaw.net on Wed Dec 15 11:08:44 2004)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi,

On 12/15/04 11:08:44, Ian Kent wrote:
> On Sat, 11 Dec 2004, Thomas Jahns wrote:
> > I'm currently experimenting with a script-created map and face the
> > following two problems:
> >
> > - After the script rewrites the map, I need to kill -HUP the
> > corresponding automount to reread the map, the documentation says
> > the daemon would read a changed map on next access of the
> > directory?
> 
> Known problem with 4.1.
> But what vesion are you running?

sorry I forgot to mention some essential information it seems, I use  
the 4.1.3-6 debian package.

> >
> > - Unfortunately there exists the possibility, that the script might
> > leave the map empty. The corresponding automount process will then
> > exit. Is there perhaps some comment convention or anything else I
> > could do to keep the automount process running?
> 
> Known problem but not yet fixed.

Okay, could I perhaps add some dummy entry? Any device/location I could  
specify that would never ever get mounted?

Regards,
Thomas Jahns
-- 
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9
