From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs Negative cache
Date: Mon, 14 Sep 2009 17:03:19 +0800
Message-ID: <4AAE06D7.3090703@themaw.net>
References: <4AADEE87.3040609@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4AADEE87.3040609@s3group.cz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Ondrej Valousek wrote:
> Hi Ian,
> 
> Can we expect someday autofs in RHEL-5 to have a working negative cache?
> Seems like it still does not work in the last update (5.4):

You'll need to be a bit more specific about what is wrong.

What is your impression of what is actually happening below?

Be aware that the negative caching cannot be done in the 2.6 kernel
module so we will always get lookups coming to the daemon. Also, some
things such as "cd" always cause multiple call backs so we will see
multiple requests although the actual map lookup and mount attempt
should be eliminated. Are you saying that maybe I'm checking too late
during the call back?

> 
> Sep 14 09:14:57 dorado_v1 automount[16281]:
> handle_packet_missing_indirect: token 132, name test, request pid 16183
> Sep 14 09:14:57 dorado_v1 automount[16281]: attempting to mount entry
> /proj/test
> Sep 14 09:14:57 dorado_v1 automount[16281]: file map not found
> Sep 14 09:14:57 dorado_v1 automount[16281]: lookup_mount: lookup(yp):
> looking up test
> Sep 14 09:14:57 dorado_v1 automount[16281]: ioctl_send_fail: token = 132
> Sep 14 09:14:57 dorado_v1 automount[16281]: failed to mount /proj/test
> Sep 14 09:14:58 dorado_v1 automount[16281]: handle_packet: type = 3
> Sep 14 09:14:58 dorado_v1 automount[16281]:
> handle_packet_missing_indirect: token 133, name test, request pid 16183
> Sep 14 09:14:58 dorado_v1 automount[16281]: attempting to mount entry
> /proj/test
> Sep 14 09:14:58 dorado_v1 automount[16281]: file map not found
> Sep 14 09:14:58 dorado_v1 automount[16281]: lookup_mount: lookup(yp):
> looking up test
> Sep 14 09:14:58 dorado_v1 automount[16281]: ioctl_send_fail: token = 133
> Sep 14 09:14:58 dorado_v1 automount[16281]: handle_packet: type = 3
> Sep 14 09:14:58 dorado_v1 automount[16281]:
> handle_packet_missing_indirect: token 134, name test, request pid 16183
> Sep 14 09:14:58 dorado_v1 automount[16281]: failed to mount /proj/test
> Sep 14 09:14:58 dorado_v1 automount[16281]: attempting to mount entry
> /proj/test
> Sep 14 09:14:58 dorado_v1 automount[16281]: file map not found
> Sep 14 09:14:58 dorado_v1 automount[16281]: lookup_mount: lookup(yp):
> looking up test
> Sep 14 09:14:58 dorado_v1 automount[16281]: ioctl_send_fail: token = 134
> Sep 14 09:14:58 dorado_v1 automount[16281]: failed to mount /proj/test
> Sep 14 09:14:58 dorado_v1 automount[16281]: handle_packet: type = 3
> Sep 14 09:14:58 dorado_v1 automount[16281]:
> handle_packet_missing_indirect: token 135, name test, request pid 16183
> 
> Thanks,
> Ondrej
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
