From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Noob Alert! - automounting /home
Date: Mon, 17 Apr 2006 11:06:37 -0400
Message-ID: <x498xq4b5s2.fsf@segfault.boston.redhat.com>
References: <e1pa9l$1ut$1@sea.gmane.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <e1pa9l$1ut$1@sea.gmane.org> (Ian Pilcher's message of "Fri, 14
	Apr 2006 18:12:53 -0500")
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
Content-Transfer-Encoding: 7bit
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Noob Alert! - automounting /home; Ian Pilcher <i.pilcher@comcast.net> adds:

i.pilcher> Apologies in advance for what seems like a stupid question.  For
i.pilcher> my autofs "project", I am trying to automount /home.

i.pilcher> My auto.master contains:

i.pilcher>     /- /etc/auto.direct

i.pilcher> And auto.direct contains:

i.pilcher>     /home -fstype=nfs4 192.168.3.1:/

Direct mounts on top-level directories are not currently supported.  You're
better off doing something like this:

auto.master:
/home   /etc/auto.home

auto.home:
*       -fstype=nfs4 192.168.3.1:/&

This is a direct translation of your maps above.  I'm not certain that this
is really what you want.

-Jeff
