From: Ian Pilcher <i.pilcher@comcast.net>
Subject: Noob Alert! - automounting /home
Date: Fri, 14 Apr 2006 18:12:53 -0500
Message-ID: <e1pa9l$1ut$1@sea.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Apologies in advance for what seems like a stupid question.  For my
autofs "project", I am trying to automount /home.

My auto.master contains:

    /-      /etc/auto.direct

And auto.direct contains:

    /home   -fstype=nfs4    192.168.3.1:/

When I start autofs, the following message is logged:

    cache_ghost: entry in file:/etc/auto.direct not valid map format,
        key /home

This is RHEL 4 update 3, with kernel-2.6.9-34.EL and autofs-4.1.3-169.

What am I doing wrong?

Thanks!

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================
