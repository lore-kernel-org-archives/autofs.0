From: Johan van den Dorpe <johan.vandendorpe@framestore-cfc.com>
Subject: Re: subdirs trying to be mounted when using ghosting
Date: Wed, 25 Jan 2006 11:50:11 +0000
Message-ID: <43D765F3.10506@framestore-cfc.com>
References: <43D6589B.6030102@framestore-cfc.com>
	<17366.24875.680488.918796@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17366.24875.680488.918796@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jmoyer@redhat.com
Cc: autofs mailing list <autofs@linux.kernel.org>

Jeff Moyer wrote:
> ==> Regarding [autofs] subdirs trying to be mounted when using ghosting; Johan van den Dorpe <johan.vandendorpe@framestore-cfc.com> adds:
> 
> johan.vandendorpe> Hi guys We're having a problem when trying to access a
> johan.vandendorpe> subdir of an automount directory that isn't
> johan.vandendorpe> mounted. Instead of looking up the mount entry for the
> johan.vandendorpe> directory, a subdir is looked up instead. If the exact
> johan.vandendorpe> dir of the entry is accessed, then it mounts fine.
> 
> Fixed by Ian in more recent kernels.  Patch was something like the
> attached...

Thanks very much Jeff, Ian. No errors this morning, but after the last 
kernel change it was a couple of days before they cropped up... so we'll 
see how we go.

Thanks again.

-- 
Johan van den Dorpe
Systems Administrator, Framestore CFC
020 7106 2441
