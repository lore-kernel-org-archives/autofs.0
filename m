From: Ian Kent <raven@themaw.net>
Subject: Re: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Tue, 19 Apr 2005 14:37:15 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504191434350.17350@wombat.indigo.net.au>
References: <200504190130.j3J1UCKj002166@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200504190130.j3J1UCKj002166@cornholio.qualcomm.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Mon, 18 Apr 2005, Michael Marion wrote:

> On 16 Apr, Daniel Andre Vaquero wrote:
> 
> > After some days of testing with upstream version 4.1.4, I noticed that it
> > is also broken (although mount failures occur less frequently). My scenario
> > consists of a single server, with no replicated mounts. Debugging the code,
> 
> Hmm... so you're saying that this happens even when you have just one mount
> listed in the map?  Odd since the subroutine shouldn't even do the rpc ping if
> there's only one possible mount.. at least it seems that way.

I've said that before but I was wrong. Sorry.

> 
> I'll be doing some testing here tomorrow as well, since this sounds like it
> may solve the problem we've been having with lsf jobs submitted to linux hosts
> for a long time now... and has been a big thorn in our side.  The fact that
> it's a timing issue and it seems to happen more often when the filer in
> question is heavily loaded would seem to reinforce that this might be the
> cause as well.

We have two patches for this issue now.
Since this is still a problem I'll be working on this next (again).

Ian
