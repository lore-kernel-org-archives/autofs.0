From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: autofs4 and NIS
Date: Mon, 05 Jan 2004 10:28:01 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FF98281.E4AEE29A@ssa.crane.navy.mil>
References: <200401010159.12640.autofs@dylan.me.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: Dylan <autofs@dylan.me.uk>
Cc: autofs mailing list <autofs@linux.kernel.org>

Dylan wrote:
> 
> Hello all,
> 
> I'm currently using autofs4 to mount nfs shares. The config files are
> distributed via NIS, which overall is working without a hitch. I have
> two related problems, however...
> 
> It is, obviously, necessary to restart the NIS server from time to time,
> in order to take account of config changes (usually changes to user
> accounts.) When I do this, the following occurs:
<SNIP>
I am a bit confused here. 
Why do you need to _restart_ the NIS server to push out the changes for USER
ACCOUNTS?

All of the systems I currently work with have have a Makefile in /var/yp, and
you just need to do a cd /var/yp;make (or make PARTICULAR_CONFIG_FILE) and the
updated user data is pushed to the NIS client machines.

Although when I run 'make -n' I do see some "kill -TERM 0" buried in there,
they look to only be ran if the awk commands before them return a non-zero
exit status.

-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane) 
Harnessing the Power of Technology for the Warfighter
