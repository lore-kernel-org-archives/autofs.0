From: David Howells <dhowells@redhat.com>
Subject: Re: stat -L triggering mount (behavior change starting
	with 2.6.38-rc1)
Date: Fri, 01 Apr 2011 10:19:58 +0100
Message-ID: <2355.1301649598@redhat.com>
References: <1301632038.2880.11.camel@perseus>
	<AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1301632038.2880.11.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: dhowells@redhat.com, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>


Hi Leonardo,

Could you send us a strace of "ls -l" on your autofs directory?

I think the problem is not lstat() calls, but rather getxattr() calls.

Thanks,
David
