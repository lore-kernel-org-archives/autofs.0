From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs error
Date: Tue, 02 Jan 2007 11:31:52 -0500
Message-ID: <x49zm91wft3.fsf@segfault.boston.devel.redhat.com>
References: <458AE13C.3060902@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <458AE13C.3060902@inf.utfsm.cl> (Miguel Varas's message of "Thu,
	21 Dec 2006 16:32:12 -0300")
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
To: Miguel Varas <mvaras@inf.utfsm.cl>
Cc: autofs@linux.kernel.org

==> On Thu, 21 Dec 2006 16:32:12 -0300, Miguel Varas <mvaras@inf.utfsm.cl> said:

Miguel> the following error is causes falls of autofs.....it happens
Miguel> when using different kernels now i m running Linux
Miguel> inti.inf.utfsm.cl 2.6.9-42.0.3.plus.c4 #1 Fri Oct 6 10:58:59
Miguel> CDT 2006 x86_64 x86_64 x86_64 GNU/Linux


Miguel> inti kernel: automount[11720]: segfault at 0000002b592133b8
Miguel> rip 0000002a9586403f rsp 0000007fbfffd0d0 error 4 Dec 21
Miguel> 16:27:58 inti kernel: automount[11723]: segfault at
Miguel> 0000002b592133b8 rip 0000002a9586403f rsp 0000007fbfffd0d0
Miguel> error 4 Dec 21 16:27:58 inti kernel: automount[11724]:
Miguel> segfault at 0000002b592133b8 rip 0000002a9586403f rsp
Miguel> 0000007fbfffd0d0 error 4

We're going to need a bit more information than this.  What version of
autofs?  Did it leave a core file?  Are there any messages in the
logs?  What do your maps looks like?  How is /etc/nsswitch.conf
configured?

For a list of the items required for fixing bugs, please see my people
page:
  http://people.redhat.com/jmoyer/

Thnaks!

Jeff
