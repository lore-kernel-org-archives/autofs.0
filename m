From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: questions on auto.master file format
Date: Wed, 3 Mar 2004 09:43:15 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16453.61187.553910.939557@segfault.boston.redhat.com>
References: <16452.51314.769206.991484@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0403031455220.16583@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403031455220.16583@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] questions on auto.master file format; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 2 Mar 2004, Jeff Moyer wrote:
>> Hello,
>> 
>> Reading through Sun's documentation, it seems that mount options
>> specified in auto.master should begin with a leading dash.  See the
>> example here:
http> //docs.sun.com/db/doc/816-0211/6m6nc66nc?q=automount&a=view

raven> What makes you think that?  Looks like the options are for the
raven> automounter not mount.

,----
| # Master map for automounter
| #
| +auto_master
| /net          -hosts    -nosuid
| /home         auto_home
| /xfn          -xfn
| 
| Optional mount options may be supplied as an optional third field in the
| each entry.
`----

Have I misinterpreted this?  Looks to me like nosuid is a mount option.

Thanks!

Jeff
