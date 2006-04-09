From: Ian Kent <raven@themaw.net>
Subject: Re: bind mount not working as expected
Date: Sun, 9 Apr 2006 12:24:57 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604091222430.3969@eagle.themaw.net>
References: <20060406152922.GD10241@nmt.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060406152922.GD10241@nmt.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Anthony M. Martinez" <twopir@nmt.edu>
Cc: autofs@linux.kernel.org, Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>

On Thu, 6 Apr 2006, Anthony M. Martinez wrote:

> As suggested, I am forwarding this question to the autofs mailing list,
> since my problem doesn't seem to be Timo's patch. 
> 
> On Fri, Mar 24, 2006 at 06:05:31PM +0100, Timo Felbinger wrote:
> > On Thu, Mar 23, 2006 at 09:57:15AM -0700, Pi (aka Anthony Martinez) wrote:
> > > > > 
> > > > Is it correct that this is a "program" map which is to telling
> > > > automount to mount /fs/administratium/accounts/p/pi as /u/pi,
> > > > and this information is taken from an ldap entry containing the
> > > > attributes
> > > >   uid: pi
> > > >   tccRawHomeDir: /fs/administratium/accounts/p/pi
                        ^
Where's the hostname on this !
tccRawHomeDir: :/fs/administratium/accounts/p/pi
               ^

Sun map escape might be needed?

Ian
