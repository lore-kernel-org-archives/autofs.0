From: Michael <michael@kmaclub.com>
Subject: Automounting DVD images
Date: Fri, 08 Dec 2006 09:59:12 -0700
Message-ID: <457999E0.2040808@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs mailing list <autofs@linux.kernel.org>

Hello,

I have been trying to get autofs to mount DVD iso images but so far have 
been unsuccessful.  I want to make this work from various client 
machines and not on the machine that servers out the iso.

I tried some examples from the web but can't seem to make them work.  I 
can mount the file by hand  over NFS without any issues.

Here is my configuration

NIS:

auto.master
/mythtv         auto.mythtv     
bg,hard,intr,retry=10000,rsize=32768,wsize=32768,timeo=600,nfsvers=3,tcp

auto.mythtv
iso             --timeout=60 -fstype=autofs     auto.mythtv.iso
video           -rw             filer:/export/services/mythtv/video

auto.mythtv.iso
* -fstype=iso9660,ro,loop       /mythtv/video/Movies/&

I have tried various incarnations of the auto.mythtv.iso map but none 
actually worked.  Can someone give me a hint?

[root@fc5 mythtv]# cd /mythtv/iso
[root@fc5 iso]# cd MOVIE.iso
-bash: cd: MOVIE.iso: No such file or directory

Here is log from a FC5 box with autofs.4.1.4-33
Dec  8 09:44:19 fc5 automount[30292]: failed to mount /mythtv/iso/MOVIE.iso

Here is the log from a FC6 box with autofs 5.0.1-0.rc2.28.1
Dec  8 09:50:20 fc6 automount[2557]: mounted indirect mount on 
/mythtv/iso with timeout 300, freq 75 seconds
Dec  8 09:50:20 fc6 automount[2557]: ghosting enabled
Dec  8 09:50:20 fc6 automount[2557]: mounted /mythtv/iso
Dec  8 09:50:24 fc6 automount[2557]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 09:50:24 fc6 automount[2557]: lookup_name_file_source_instance: 
file map not found
Dec  8 09:50:24 fc6 automount[2557]: failed to mount /mythtv/iso/MOVIE.iso
Dec  8 09:50:24 fc6 automount[2557]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 09:50:24 fc6 automount[2557]: lookup_name_file_source_instance: 
file map not found
Dec  8 09:50:24 fc6 automount[2557]: failed to mount /mythtv/iso/MOVIE.iso
Dec  8 09:50:24 fc6 automount[2557]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 09:50:24 fc6 automount[2557]: lookup_name_file_source_instance: 
file map not found
Dec  8 09:50:24 fc6 automount[2557]: failed to mount /mythtv/iso/MOVIE.iso

Thanks,
Michael
