From: "atlantos41" <atlantos41@yandex.ru>
Subject: Re: Is autofs4 8-bit compatible?
Date: Tue, 15 Mar 2005 10:07:25 +0300 (MSK)
Message-ID: <423689AD.000001.28955@colgate.yandex.ru>
Reply-To: atlantos41@yandex.ru
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tuesday 15 March 2005 08:15, Ian Kent wrote:

> This is not nearly as much info as you should see.
> In particular what I'm actually after (the parsing debug output) is not
> there.
>
> Can you check to see if you are sending debug output to syslog please?
>
> I remember I had to alter my syslog.conf on FC2 at one point.
>
> Ian

Strange. I do
~ automount --timeout=60 --verbose /smb file /etc/auto.smb
~ cd /smb/test_data<cyrchar>est
bash: cd: /smb/test_data<cyrchar>est: No such file or directory
~ kill -term `pidof automount`

My syslog.conf have lines:
*.debug          /var/log/messages

And in /var/log/messages I've got only this lines:

Mar 15 08:53:31 localhost automount[17620]: starting automounter version 4.1.4_beta2, path = /smb, maptype = file, mapname = /etc/auto.smb
Mar 15 08:53:31 localhost automount[17620]: using kernel protocol version 4.05
Mar 15 08:53:31 localhost automount[17620]: using timeout 60 seconds; freq 15 secs
Mar 15 08:53:35 localhost automount[17620]: attempting to mount entry /smb/test_data
Mar 15 08:53:35 localhost automount[17626]: failed to mount /smb/test_data
Mar 15 08:53:35 localhost automount[17626]: umount_multi: no mounts found under /smb/test_data
Mar 15 08:53:43 localhost automount[17620]: prep_shutdown: state = 1 
Mar 15 08:53:43 localhost automount[17620]: signal_children: send 12 to process group 17620
Mar 15 08:53:43 localhost automount[17620]: umount_multi: no mounts found under /smb
Mar 15 08:53:43 localhost automount[17620]: shut down, path = /smb
