From: raven@themaw.net
Subject: Re: mount 2.12: proplist and failed mounts
Date: Fri, 25 Jun 2004 23:00:36 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406252259180.1375@donald.themaw.net>
References: <20040625110243.GH22003@neu.nirvana>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040625110243.GH22003@neu.nirvana>
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
To: Axel Thimm <Axel.Thimm@atrpms.net>
Cc: autofs@linux.kernel.org

On Fri, 25 Jun 2004, Axel Thimm wrote:

> Hi,
> 
> I was happily using autofs 4.1.3 with mount 2.11y. The maps contained
> the proplist option (we share the maps with some OSF1 boxes), but that
> did not disturb.
> 
> for other reasons I had to upgrade mount to 2.11 (part of
> util-linux). Suddenly autofs will not mount anymore with errors like:
> 
> Jun 25 12:25:50 heretic automount[12646]: failed to mount /home/thimm
> Jun 25 12:25:50 heretic automount[12648]: >> Unsupported nfs mount option: proplist
> Jun 25 12:25:50 heretic automount[12648]: mount(nfs): nfs: mount failure nukleon:/amd/nukleon/1/home/ag-linke/thimm on /home/thimm
> 
> I tested mount -o proplist and I got the above error and the exit code was 32:
> # mount -o proplist nukleon:/amd/nukleon/1/home/ag-linke/thimm /home/thimm
> Unsupported nfs mount option: proplist
> # echo $?
> 32
> 
> OK, so I thought mount has become quite picky now, and downgraded. I
> retried the manual mount and got the same error & exit code!
> 
> But autofs works properly again?!?

OK. I'm confused as well.

I'll play with some invalid options ove rthe weekend and see what I can 
do.

Ian
