From: Rezk Mekhael <rezk.mekhael@gmail.com>
Subject: ls command fails to properly list contents of directories
Date: Thu, 5 Nov 2009 22:19:25 -0800
Message-ID: <2590cb1a0911052219i260a3c07ib57edd321f21b4be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0045731600505916954=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:date:message-id:subject
	:from:to:content-type;
	bh=UNxD3d7NaG4MqAZDXRbM/2EHAo8CdxUF09/oIU6oXaQ=;
	b=aB1wuO0QgNjaQ4HGwIacGYyz9MjHFH+9Ue4wbLg4UyE3XHUx7Zc1syPv70xbIHVSCv
	9b1UWbvBzIudvjuzBtlDAYsanK6e18NR7/EM3QqUXgGyiSs341y0t7DlzUVI32BBykk+
	TtbQSo+TUzUZFHZtuh+L0aIxRDClRs3u+AOk0=
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
To: autofs@linux.kernel.org

--===============0045731600505916954==
Content-Type: multipart/alternative; boundary=00504502c06f57a4750477add358

--00504502c06f57a4750477add358
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
I have a question about automout over linux:
Why Standard UNIX LS command  fails to properly list contents of directories
on *untriggered* automounts using nfs?


-- 
Rezk Mekhael

--00504502c06f57a4750477add358
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi all,</div>
<div>I have a question about automout over linux:</div>
<div>Why Standard UNIX LS command =A0fails to properly list contents of dir=
ectories<br>on <strong>untriggered</strong> automounts using nfs?</div>
<div><br clear=3D"all"><br>-- <br>Rezk Mekhael<br><br></div>

--00504502c06f57a4750477add358--


--===============0045731600505916954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0045731600505916954==--

