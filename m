From: Jeff Moyer <jmoyer@redhat.com>
Subject: RE: autofs-4.1.3 rpms available
Date: Fri, 4 Jun 2004 16:09:45 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16576.55049.875986.881088@segfault.boston.redhat.com>
References: <6AB920CC10586340BE1674976E0A991D01755BC8@slexch2.sugarland.unocal.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <6AB920CC10586340BE1674976E0A991D01755BC8@slexch2.sugarland.unocal.com>
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
To: "Crawford, Philip I." <philip.crawford@unocal.com>
Cc: autofs@linux.kernel.org

==> Regarding RE: [autofs] autofs-4.1.3 rpms available; "Crawford, Philip I." <philip.crawford@unocal.com> adds:

philip.crawford> Hi Jeff / List: With regards to your RHEL3 version of the
philip.crawford> RPM - doesn't the kernel need to be patched first?  We
philip.crawford> have been unable to get ghosting work just using the RPM.
philip.crawford> If there are patches needed where can I get these?  The
philip.crawford> ones Ian released last week aren't for RHEL and won't
philip.crawford> patch cleanly.

Yes, that is quite correct, though all of the features you were using in
3.1.7 should work fine with the autofs4 userspace and the autofs3 kernel
module.

I have patches for RHEL 3 which I am currently testing internally.  I'll
let you know when they are publically available.

Thanks!

Jeff
