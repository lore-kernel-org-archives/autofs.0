From: Krish Pillai <kpillai@lhup.edu>
Subject: autofs mounting certain home directories for no reason
Date: Mon, 16 Mar 2009 20:05:30 -0400
Message-ID: <49BEE94A.1000608@lhup.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070207040806050501020203"
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

This is a multi-part message in MIME format.
--------------070207040806050501020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I just upgraded from Fedora 8 to Fedora 10 
(2.6.27.19-170.2.35.fc10.x86_64) on some of my machines and autofs seems 
to be acting up. My server is running fc7.
I have ypbind and automount running on all clients and the clients seem 
to be repeatedly sending mount/umount  requests to the server on behalf 
of users who are not even trying to log in. As a result I see home 
directories getting mounted on the clients and getting unmounted all the 
time. Is this a known problem? If so, is there a fix?
Krish

--------------070207040806050501020203
Content-Type: text/x-vcard; charset=utf-8;
 name="kpillai.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kpillai.vcf"

begin:vcard
fn:Dr. Krish Pillai
n:Pillai;Krish
org:Lock Haven University of Pennsylvania;Computer Science
adr:401 N. Fairview Street;;Rm 224 Akeley Hall;Lock Haven;PA;17745;United States of America
email;internet:kpillai@lhup.edu
title:Assistant Professor
tel;work:570 484 2346
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070207040806050501020203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------070207040806050501020203--

