From: Max Matveev <makc@melbourne.sgi.com>
Subject: Re: Difference in behaviour between 4.1.3 and 4.1.4
Date: 03 Aug 2005 18:13:30 +1000
Message-ID: <net7jf3mo9h.fsf@kuku.melbourne.sgi.com>
References: <netoe8gn34v.fsf@kuku.melbourne.sgi.com>
	<17135.29013.324264.704045@segfault.boston.redhat.com>
	<17135.30311.969737.212368@kuku.melbourne.sgi.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Sender: max.matveev@sgi.com
In-Reply-To: <17135.30311.969737.212368@kuku.melbourne.sgi.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

>>>>> "makc" == Max Matveev <makc@sgi.com> writes:
>>>>> "jmoyer" == Jeff Moyer <jmoyer@redhat.com> writes:

 jmoyer> I have never seen this issue.  I haven't seen it in the
 jmoyer> upstream autofs package nor in any variant of the Red Hat
 jmoyer> packages with which I work.

 makc> Dang! I was hopeing it was a known issue and I wouldn't have to dive
 makc> into the code - apparently 4.0.0-pre-something on Mandrake behave
 makc> similarly. Maybe it's a kernel module issue, not the user-space
 makc> automounter one.

Scrap that - happened to be a mismatch between kernel and user space:
kernel at autofs3, userspace at autofs4, modprobe.conf got clobbered
during update.

max
