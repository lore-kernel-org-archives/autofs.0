From: Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in
	super block info
Date: Fri, 15 Jan 2010 11:36:15 -0600
Message-ID: <524f69651001150936q2405a8ccp7433e986e647f7a1@mail.gmail.com>
References: <1261611423-4396-1-git-send-email-vaurora@redhat.com>
	<1261611423-4396-2-git-send-email-vaurora@redhat.com>
	<20100102004423.GA2131@zeus.themaw.net>
	<20100114054322.GA16106@ZenIV.linux.org.uk>
	<20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net>
	<20100115080323.GK19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5873867065334347719=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:in-reply-to:references
	:date:message-id:subject:from:to:cc:content-type;
	bh=hYa1zRNeBJYn9FeRcdyef8sjK2exUZOf2ZIEeSw/PtI=;
	b=QVjhUidjBrwBHrwWHFG6+VR7oJm4xDSMmVA0aaWYVtOzMAwK+WRGOx9Ra/M89Rl4GS
	dqw1egrVSQr15bOCUyJLwKbBKLLZo+gFcPg6qgnDiMuw0G5X9Mre3kYHrupI5um9WjsW
	ccv7avtYEjgYV2D+ybJkrN2aEvtUf4uf2cJS0=
In-Reply-To: <20100115080323.GK19799@ZenIV.linux.org.uk>
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
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: autofs@linux.kernel.org, dhowells@redhat.com, Trond.Myklebust@netapp.com, sfrench@samba.org, Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, Ian Kent <raven@themaw.net>

--===============5873867065334347719==
Content-Type: multipart/alternative; boundary=001636b2ad06c44d6d047d3770ca

--001636b2ad06c44d6d047d3770ca
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jan 15, 2010 at 2:03 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:

> [AFS, CIFS and NFS maintainers added to Cc]
>        * WTF is CIFS doing setting MNT_SHRINKABLE on *parent* vfsmount?
> Blindly, not even bothering to cooperate with mnt_make_readonly() and
> its ilk.  Most of all, _why_?  It's child that should be marked so, not
> the parent...
>

Yes. Looks like a bug. Thanks for spotting this.  Doublechecking with Igor
(who wrote this section).

-- 
Thanks,

Steve

--001636b2ad06c44d6d047d3770ca
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Jan 15, 2010 at 2:03 AM, Al Viro=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:viro@zeniv.linux.org.uk">viro@zeni=
v.linux.org.uk</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
[AFS, CIFS and NFS maintainers added to Cc]<br>
=A0 =A0 =A0=A0 * WTF is CIFS doing setting MNT_SHRINKABLE on *parent* vfsmo=
unt?<br>
Blindly, not even bothering to cooperate with mnt_make_readonly() and<br>
its ilk. =A0Most of all, _why_? =A0It&#39;s child that should be marked so,=
 not<br>
the parent...<br>
 </blockquote></div><br>Yes. Looks like a bug. Thanks for spotting this.=A0=
 Doublechecking with Igor (who wrote this section).<br clear=3D"all"><br>--=
 <br>Thanks,<br><br>Steve<br>

--001636b2ad06c44d6d047d3770ca--


--===============5873867065334347719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5873867065334347719==--

