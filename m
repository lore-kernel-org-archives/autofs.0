From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Re: [NFS] udp ports not being released
Date: Tue, 23 Nov 2004 11:50:08 -0500
Message-ID: <16803.27200.583030.756208@segfault.boston.redhat.com>
References: <41A2413A.9020800@analog.com>
	<41A24453.6000907@sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41A24453.6000907@sun.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, Dwight Marzolf <dwight.marzolf@analog.com>, nfs@lists.sourceforge.net, Ian Kent <raven@themaw.net>

==> Regarding [autofs] Re: [NFS] udp ports not being released; Mike Waychison <Michael.Waychison@sun.com> adds:

Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1

Michael.Waychison> Dwight Marzolf wrote:
>> We are running RedHat 8, kernel 2.4.20-20.8smp and autofs 4.1.2.  We
>> were having a variety of automount problems until a kernel patch was
>> recommended.  We added this patch, recompiled our kernel, and
>> distributed the patched kernel to all of our workstations.  About 90% of
>> our problems disappeared.  But one problem seems to remain.
>> 
>> When /net is used to mount directories, most of the time the udp port
>> used for that nfs mount operation is not released once the /net mount
>> times out.  Depending on the level of activity on a machine, over the
>> period of several days, all the available reserved ports are used up. At
>> that point the user on the workstation cannot cd to any mount points in
>> our automount maps except the ones already mounted.  In the
>> /var/log/messages the following error occurs for attempted mounts:

Michael.Waychison> IIRC, automount 4.1.2 had a fd leak, that was fixed in
Michael.Waychison> 4.1.3

Michael.Waychison> Ian?

I'm not Ian, but I can answer.  That leak still exists in 4.1.3.  There are
a couple of patches posted that deal with this problem and a related
problem.  One fixes the socket leak, the other teaches the udp rpc_ping
function to not use reserved ports.

-Jeff
