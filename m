From: Paul Smith <psmith@netezza.com>
Subject: Sample auto.net provided with autofs is incorrect
Date: Thu, 24 May 2007 13:34:21 -0400
Message-ID: <1180028061.19818.41.camel@psmithub>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-J3Ksmzk7ujtHWSoJ6yxP"
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


--=-J3Ksmzk7ujtHWSoJ6yxP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all; I sent this on May 1 but I haven't seen it come through yet?


Please see this bug I just reported against Ubuntu:

https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/111612

I believe this problem also exists in the original autofs package.
However, I can't seem to find the source anywhere; the freshmeat page
for autofs looks quite out of date and doesn't have any homepage/etc.
info, and Google searches came up empty as well.

I attach a patch below.

-- 
-----------------------------------------------------------------------------
 Paul D. Smith <psmith@netezza.com>                       http://netezza.com
 "Please remain calm--I may be mad, but I am a professional."--Mad Scientist
-----------------------------------------------------------------------------
      These are my opinions--Netezza takes no responsibility for them.

--=-J3Ksmzk7ujtHWSoJ6yxP
Content-Disposition: attachment; filename=autofs-auto.net.patch
Content-Type: text/x-patch; name=autofs-auto.net.patch; charset=us-ascii
Content-Transfer-Encoding: base64

LS0tIC9ldGMvYXV0by5uZXQtZGlzdAkyMDA3LTAyLTA4IDExOjIwOjA3LjAwMDAwMDAwMCAtMDUw
MA0KKysrIC9ldGMvYXV0by5uZXQJMjAwNy0wNS0wMSAxNjoxNjoxMi4wMDAwMDAwMDAgLTA0MDAN
CkBAIC0zNyw3ICszNyw3IEBADQogIyBOZXdlciBkaXN0cmlidXRpb25zIGdldCB0aGlzIHJpZ2h0
DQogU0hPV01PVU5UPSIkU01OVCAtLW5vLWhlYWRlcnMgLWUgJGtleSINCiANCi0kU0hPV01PVU5U
IHwgTENfQUxMPUMgc29ydCAtdSAtayAxIHwgXA0KKyRTSE9XTU9VTlQgfCBMQ19BTEw9QyBjdXQg
LWRcICAtZjEgfCBMQ19BTEw9QyBzb3J0IC11IHwgXA0KIAlhd2sgLXYga2V5PSIka2V5IiAtdiBv
cHRzPSIkb3B0cyIgLS0gJw0KIAlCRUdJTgl7IE9SUz0iIjsgZmlyc3Q9MSB9DQogCQl7IGlmIChm
aXJzdCkgeyBwcmludCBvcHRzOyBmaXJzdD0wIH07IHByaW50ICIgXFxcblx0IiAkMSwga2V5ICI6
IiAkMSB9DQo=


--=-J3Ksmzk7ujtHWSoJ6yxP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-J3Ksmzk7ujtHWSoJ6yxP--

