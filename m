From: Ondrej Valousek <webserv@s3group.com>
Subject: Autofs dump map option
Date: Fri, 05 Aug 2011 11:11:36 +0200
Message-ID: <4E3BB3C8.9040305@s3group.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2471963146863433398=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>, Ian Kent <ikent@redhat.com>

This is a multi-part message in MIME format.
--===============2471963146863433398==
Content-Type: multipart/alternative;
 boundary="------------010909060704010000000403"

This is a multi-part message in MIME format.
--------------010909060704010000000403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian,

Thanks for looking after the bugs #538408 and #704416 for me, but I have one slight problem with it:
Automouter won't show any keys in my indirect NIS maps unless I specify "BROWSE_MODE=yes".
Maybe it is expected behaviour so I was thinking - can we always force browse_mode when dumping maps?

Sorry for spotting this too late.

Thanks,
Ondrej


The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited (S3 Group). Registered in Ireland no. 378073.
Registered Office: South County Business Park, Leopardstown, Dublin 18
--------------010909060704010000000403
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body bgcolor="#ffffff" text="#000066">
    Hi Ian,<br>
    <br>
    Thanks for looking after the bugs #538408 and #704416 for me, but I
    have one slight problem with it:<br>
    Automouter won't show any keys in my indirect NIS maps unless I
    specify "BROWSE_MODE=yes".<br>
    Maybe it is expected behaviour so I was thinking - can we always
    force browse_mode when dumping maps?<br>
    <br>
    Sorry for spotting this too late.<br>
    <br>
    Thanks,<br>
    Ondrej<br>
  <BR><HR>
The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited (S3 Group). Registered in Ireland no. 378073.
Registered Office: South County Business Park, Leopardstown, Dublin 18
<BR><HR><BR></body>
</html>

--------------010909060704010000000403--


--===============2471963146863433398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2471963146863433398==--

