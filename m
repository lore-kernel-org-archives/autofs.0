From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs-4.1.3 rpms available
Date: Sat, 5 Jun 2004 22:15:33 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16578.32325.195515.925732@segfault.boston.redhat.com>
References: <6AB920CC10586340BE1674976E0A991D01755BC8@slexch2.sugarland.unocal.com>
	<16576.55049.875986.881088@segfault.boston.redhat.com>
	<20040605092241.GA4610@neu.nirvana>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040605092241.GA4610@neu.nirvana>
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
To: Axel Thimm <Axel.Thimm@atrpms.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: autofs-4.1.3 rpms available; Axel Thimm <Axel.Thimm@ATrpms.net> adds:

Axel.Thimm> On Fri, Jun 04, 2004 at 04:09:45PM -0400, Jeff Moyer wrote:
>> ==> Regarding RE: [autofs] autofs-4.1.3 rpms available; "Crawford,
>> Philip I." <philip.crawford@unocal.com> adds:
>> 
philip.crawford> Hi Jeff / List: With regards to your RHEL3 version of the
philip.crawford> RPM - doesn't the kernel need to be patched first?  We
philip.crawford> have been unable to get ghosting work just using the RPM.
philip.crawford> If there are patches needed where can I get these?  The
philip.crawford> ones Ian released last week aren't for RHEL and won't
philip.crawford> patch cleanly.
>> Yes, that is quite correct, though all of the features you were using in
>> 3.1.7 should work fine with the autofs4 userspace and the autofs3 kernel
>> module.
>> 
>> I have patches for RHEL 3 which I am currently testing internally.  I'll
>> let you know when they are publically available.

Axel.Thimm> How about external kernel module rpms? I am providing such for
Axel.Thimm> consumer line Red Hat products (RHL 7.3 to 9 and FC 1 and 2),
Axel.Thimm> and these could also be built for RHEL kernels. This makes
Axel.Thimm> testing much easier, as you don't need to involve the kernel
Axel.Thimm> masters. As soon as the external kernel module rpms prove
Axel.Thimm> themselves, you can still merge them into the kernel rpm.

From your standpoint, I'm sure this is desirable.  From my position, it
just makes more sense to keep with one version of the module: the one in
our kernel tree.  As an unfortunate side effect, this means updates to the
module only come out in tandem with the kernel release schedule.

Axel.Thimm> Some people in RH are trying to get me a RHEL license for other
Axel.Thimm> purposes, if I get one indeed, I will try to provide external
Axel.Thimm> kernel modules (but there still is a tiny two-liner patch
Axel.Thimm> needed for enabling the autofs external module, which needs to
Axel.Thimm> be in-kernel, can't say if this aplies to the current RHEL
Axel.Thimm> kernel).

It does apply to the current RHEL kernels (you need the two-liner).
Hopefully this will change in short order.

Thanks!
Jeff
