From: jmoyer@redhat.com
Subject: Re: autofs5: multiple entries with wildcards
Date: Wed, 14 Mar 2007 17:42:17 -0400
Message-ID: <m3fy878pty.fsf@redhat.com>
References: <1173907255.8503.12.camel@prometheus.workstation.sash-bielefeld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1173907255.8503.12.camel@prometheus.workstation.sash-bielefeld.net>
	(Sascha Frey's message of "Wed, 14 Mar 2007 22:20:55 +0100")
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
To: Sascha Frey <sfrey@acs-software.de>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] autofs5: multiple entries with wildcards; Sascha Frey <sfrey@acs-software.de> adds:

sfrey> Hi,
sfrey> I'm trying to set up autofs5, but I've got a problem:

sfrey> auto.master:
sfrey> /homes		/etc/auto.homes

sfrey> auto.homes:
sfrey> * -fstype=nfs,rw        homeserver1:/home/&
sfrey> * -fstype=nfs,rw        homeserver2:/home/&

sfrey> The directories on the first server are mounted. 
sfrey> But if I try to access a home which is on the second one I get a 'No
sfrey> such file or directory' error.

Your configuration is not valid.  You can use a replicated server entry,
but this is not the purpose for which it was intended.  Even so, it should
work:

* -fstype=nfs,rw        homeserver1,homeserver2:/home/&

-Jeff
