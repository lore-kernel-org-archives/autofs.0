From: "Lever, Charles" <Charles.Lever@netapp.com>
Subject: RE: is there an autofs roadmap somewhere?
Date: Fri, 25 Jun 2004 08:04:23 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <482A3FA0050D21419C269D13989C611302B07D00@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

> On Tue, 22 Jun 2004, Lever, Charles wrote:
> 
> > new to the game.
> > 
> > I'm wondering what features autofs developers have in mind for the 
> > near future.
> 
> Charles. Why did you have to ask "that" question!

i'm working with trond to build a Linux NFS client roadmap.  our
customers want a little more transparency into the Linux NFS client
development plan, and i'm trying to include autofs because it is pretty
important for them.  i actually know very little about it (so a pointer
to a primer you like would be helpful for me).

> But what functionality do you need?
> And what do you think would be useful?

no requests... just polling for information, trying to get more involved
here.  thanks!

there are some naive thoughts about error recovery and threading
architecture that could help autofs deployments in very large
environments with lots of active mounts.  but i'd like to explore the
current autofs more before stepping in it.
