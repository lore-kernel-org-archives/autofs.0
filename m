From: Andrej Filipcic <andrej.filipcic@ijs.si>
Subject: autofs-5.0.5 SIGHUP not reloading maps
Date: Wed, 25 Aug 2010 13:12:13 +0200
Message-ID: <201008251312.13265.andrej.filipcic@ijs.si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijs.si; h=
	message-id:content-transfer-encoding:content-type:content-type
	:mime-version:user-agent:date:date:subject:subject:organization
	:from:from:received:received:received; s=jakla2; t=1282734735;
	x=1285326735; bh=QjrfzODarvgd3SSQPh2ZLZSyydqM9uncsSQZXXBGnKM=; b=
	S6AbXae72SpuVRBpbhxtbALVKkTLOMaRRzdvrM7XLI8OssiGsAGGmKtsamJ9WFAc
	i3V8840iGH2HehctPgzes10VU7gDMSFrEEZlnsmCv2jkk/ErKlfumwa1vSo5M5uv
	SGjl/DAo6E0gWHfrrwRZUpvJwsAOumBfhdW8J0ahtjI=
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


Hi,

The autofs 5.0.5 with the patches till 10th of August does not reload the maps 
in auto.master. It worked well with 5.0.4 on 2.6.32.19 kernel.

I use the following in auto.master:
+/chroot/autofs.chroot

# cat /chroot/autofs.chroot 
/chroot/slc5.x86_64/net -hosts intr
/chroot/debian6.i386/net -hosts intr

At autofs startup, the autofs.chroot does not exists, but when /chroot is 
mounted, the autofs reload should make the new trees available. After the 
reload, the automount daemon cannot be stopped cleanly. 

Best regards,
Andrej

-- 
_____________________________________________________________
   prof. dr. Andrej Filipcic,   E-mail: Andrej.Filipcic@ijs.si
   Department of Experimental High Energy Physics - F9
   Jozef Stefan Institute, Jamova 39, P.o.Box 3000
   SI-1001 Ljubljana, Slovenia
   Tel.: +386-1-477-3674    Fax: +386-1-477-3166
-------------------------------------------------------------
