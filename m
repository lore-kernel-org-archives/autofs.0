From: es <es.autofs@javanet.info>
Subject: basic question on "key"
Date: Tue, 05 Oct 2004 18:19:06 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4162C97A.7080407@javanet.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hello there, I'm using autofs since a while and works very well.
Now I'd like to mount /home/milly and /home/es/Data from an NFS export. 
This means I cannot simply have /home in auto.master otherwise /home/es 
became inaccesible.
********* auto.master file
/home/milly  /etc/autofs/auto.home.milly
/home/es  /etc/autofs/auto.home.es
********* auto.home.milly
./              -fstype=nfs,rw          myhost:/home/milly

It seems I can't use ./ as key nor I can have /home/es in auto.master 
and have Data as key in auto.home.es because it will mount /home/es 
hidding the content of /home/es.

I have read trought the docs but can't find an example of this basic 
usage scenario.
TIA
Eli
