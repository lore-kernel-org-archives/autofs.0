From: raven@themaw.net
Subject: RE: is there an autofs roadmap somewhere?
Date: Fri, 25 Jun 2004 23:18:44 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406252306330.1375@donald.themaw.net>
References: <482A3FA0050D21419C269D13989C611302B07D00@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C611302B07D00@lavender-fe.eng.netapp.com>
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
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: autofs@linux.kernel.org

On Fri, 25 Jun 2004, Lever, Charles wrote:

> > On Tue, 22 Jun 2004, Lever, Charles wrote:
> > 
> > > new to the game.
> > > 
> > > I'm wondering what features autofs developers have in mind for the 
> > > near future.
> > 
> > Charles. Why did you have to ask "that" question!
> 
> i'm working with trond to build a Linux NFS client roadmap.  our
> customers want a little more transparency into the Linux NFS client
> development plan, and i'm trying to include autofs because it is pretty
> important for them.  i actually know very little about it (so a pointer
> to a primer you like would be helpful for me).

Count me in.

Not sure what you need for doco here but the automounter howto at

http://www.linux-consulting.com/Amd_AutoFS/autofs.html

has a fair bit of info about autofs and amd, although a bit out of date.

But for a description of what's expected of an automounter the

"Managing NFS and NIS" by Stern, O'Reily, Ch 13

gives a good coverage, again a little incomplete these days.

> 
> > But what functionality do you need?
> > And what do you think would be useful?
> 
> no requests... just polling for information, trying to get more involved
> here.  thanks!
> 
> there are some naive thoughts about error recovery and threading
> architecture that could help autofs deployments in very large
> environments with lots of active mounts.  but i'd like to explore the
> current autofs more before stepping in it.

I've given some thought to a change in internal design. Introducing a 
threaded model in fact. But having lots of processes around and a 
cluttered mount table need to be considered, even with the current design.

I'd be interested in hearing your ideas about a threaded design.

Ian
