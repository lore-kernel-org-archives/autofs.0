From: Thanh Tran <ttran7700@yahoo.com>
Subject: Problem Mounting CD Drive
Date: Tue, 16 Aug 2011 04:39:18 -0700 (PDT)
Message-ID: <1313494758.52256.YahooMailClassic@web161428.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1313494758; bh=WnH7ETkHSzJIINVRApp0eqzh0JwRjEHnnQD1ouBl9sw=;
	h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type;
	b=oWUdNzb9ssIbReVJKhop/wrdnw4Wb4WHabpDs6bntjUCoDhYqVwPhoyZODnIgy9fO6jyKv68rbcvpbpiE3B1HMJ9zK+fWAFKt9JdICt9WpfDKz15qDD8hxLxWe8vcb5JRSgAIAyOobO4azHsCkQmdtoEoViYCoxGQpuAOakXP90=
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

I've been having some problems with mounting my CD drive since I updated to Fedora 12.

I get this from the log.

Aug 16 06:57:11 nextgen-mm automount[769]: mount(generic): mounted /dev/scd0 type auto on /mnt/cdrom/cdrom
Aug 16 06:57:11 nextgen-mm automount[769]: mounted /mnt/cdrom/cdrom
Aug 16 07:11:45 nextgen-mm automount[769]: attempting to mount entry /mnt/cdrom/cdrom
Aug 16 07:11:52 nextgen-mm kernel: sr 2:0:0:0: [sr0] Unhandled sense code
Aug 16 07:11:52 nextgen-mm kernel: sr 2:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 16 07:11:52 nextgen-mm kernel: sr 2:0:0:0: [sr0] Sense Key : Medium Error [current] 
Aug 16 07:11:52 nextgen-mm kernel: Info fld=0x0
Aug 16 07:11:52 nextgen-mm kernel: sr 2:0:0:0: [sr0] Add. Sense: Unrecovered read error
Aug 16 07:11:52 nextgen-mm kernel: end_request: I/O error, dev sr0, sector 1208
Aug 16 07:11:52 nextgen-mm kernel: Buffer I/O error on device sr0, logical block 302


The Autofs keeps trying to mount it.  Is there a way to limit the number of re-tries. Can I do this by setting the timeout to a lower number in the configuration file?  I switched out a different USB CD drive and it works fine.  At first, I thought something was wrong with the disk.  However, I used the same disk in a different drive.  The strange part is after a few minutes it will resolve whatever issue it had with my drive?!?  Thanks in advance for any help!
