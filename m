From: Ondrej Valousek <webserv@s3group.cz>
Subject: Autofs Negative cache
Date: Mon, 14 Sep 2009 09:19:35 +0200
Message-ID: <4AADEE87.3040609@s3group.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi Ian,

Can we expect someday autofs in RHEL-5 to have a working negative cache?
Seems like it still does not work in the last update (5.4):

Sep 14 09:14:57 dorado_v1 automount[16281]: 
handle_packet_missing_indirect: token 132, name test, request pid 16183
Sep 14 09:14:57 dorado_v1 automount[16281]: attempting to mount entry 
/proj/test
Sep 14 09:14:57 dorado_v1 automount[16281]: file map not found
Sep 14 09:14:57 dorado_v1 automount[16281]: lookup_mount: lookup(yp): 
looking up test
Sep 14 09:14:57 dorado_v1 automount[16281]: ioctl_send_fail: token = 132
Sep 14 09:14:57 dorado_v1 automount[16281]: failed to mount /proj/test
Sep 14 09:14:58 dorado_v1 automount[16281]: handle_packet: type = 3
Sep 14 09:14:58 dorado_v1 automount[16281]: 
handle_packet_missing_indirect: token 133, name test, request pid 16183
Sep 14 09:14:58 dorado_v1 automount[16281]: attempting to mount entry 
/proj/test
Sep 14 09:14:58 dorado_v1 automount[16281]: file map not found
Sep 14 09:14:58 dorado_v1 automount[16281]: lookup_mount: lookup(yp): 
looking up test
Sep 14 09:14:58 dorado_v1 automount[16281]: ioctl_send_fail: token = 133
Sep 14 09:14:58 dorado_v1 automount[16281]: handle_packet: type = 3
Sep 14 09:14:58 dorado_v1 automount[16281]: 
handle_packet_missing_indirect: token 134, name test, request pid 16183
Sep 14 09:14:58 dorado_v1 automount[16281]: failed to mount /proj/test
Sep 14 09:14:58 dorado_v1 automount[16281]: attempting to mount entry 
/proj/test
Sep 14 09:14:58 dorado_v1 automount[16281]: file map not found
Sep 14 09:14:58 dorado_v1 automount[16281]: lookup_mount: lookup(yp): 
looking up test
Sep 14 09:14:58 dorado_v1 automount[16281]: ioctl_send_fail: token = 134
Sep 14 09:14:58 dorado_v1 automount[16281]: failed to mount /proj/test
Sep 14 09:14:58 dorado_v1 automount[16281]: handle_packet: type = 3
Sep 14 09:14:58 dorado_v1 automount[16281]: 
handle_packet_missing_indirect: token 135, name test, request pid 16183

Thanks,
Ondrej
