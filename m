From: Techie <techchavez@gmail.com>
Subject: Executable maps
Date: Mon, 7 Jun 2010 16:33:39 -0700
Message-ID: <AANLkTin8PTdQLShcrAk_cT21pFfwcuatXvMNMQSgYmO3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:received:date:message-id
	:subject:from:to:content-type;
	bh=GeIl8kiqD9u5YRdpNSSUaZjGcTTb/uI4/3SwNSWZthA=;
	b=ABHRySVooJVpPONviTkbh3eDFs2ZCc8A6P4plY3vFqf+6uut6U2qHflIqr9wyvrdxD
	0h/8C0iZ+Og3d34WF7RoW0i45WFyVmtaKnSUNP1IZLR2ZDjvdMuHmsXXeLvglLhEIJaE
	SxDH4nCgWOWh+7d6Bbk5zCruovU1qTRubKzJc=
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

Hi Ian, List,

2 questions..

1) Has a fix been released for the Admin or "$" shares in regards to
cifs yet? The automounter fails to mount them even though the path
looks ok. It mounts the non admin shares fine. I can mount them fine
from the CLI.

2) I have modified the auto.smb script to create a direct map since
the indirect fails to mount admin shares. Can a direct map be used as
an executable map? My feeling from my reading of the manpage is no but
maybe there is a way.

Thanks
TC
