From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Large number of mount request.
Date: Thu, 15 Jun 2006 09:21:54 -0400
Message-ID: <x49pshao8p9.fsf@segfault.boston.redhat.com>
References: <01e801c68f82$3794d8e0$6cf1718c@administrator>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <01e801c68f82$3794d8e0$6cf1718c@administrator> (Latrell's
	message of "Wed, 14 Jun 2006 15:14:43 +0800")
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
To: Latrell <is85022@cis.nctu.edu.tw>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Large number of mount request.; "Latrell" <is85022@cis.nctu.edu.tw> adds:

is85022> Hi, all:

is85022> I have a problem with the mount and umount packet.  My problem is
is85022> when I have a large number of mount requests, some mount request
is85022> packets are missing. Thus, when I "cd share1", I will get "fail to
is85022> change directory" because share1 is not mounted. Fewer mount
is85022> requests work normally. Another question, who sends the packets? 
is85022> I'm tracing source code, and found the mount and umount begain
is85022> with handle_packet() function. But I don't know how it receive the
is85022> packets.

How many mounts are we talking about?  What leads you to believe that the
kernel isn't passing mount requests to the daemon?

Please take a look at the section entitled, "Filing bug reports" on my
people page:  http://people.redhat.com/jmoyer/.

Please provide the debug logs as detailed on that page and we will see if
we can't figure out what the problem is.

Thanks,

Jeff
