From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Is autofs4 8-bit compatible?
Date: Wed, 16 Mar 2005 10:30:30 -0500
Message-ID: <16952.20758.58340.464962@segfault.boston.redhat.com>
References: <423689AD.000001.28955@colgate.yandex.ru>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <423689AD.000001.28955@colgate.yandex.ru>
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
To: atlantos41@yandex.ru
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] Is autofs4 8-bit compatible?; "atlantos41" <atlantos41@yandex.ru> adds:

atlantos41> On Tuesday 15 March 2005 08:15, Ian Kent wrote:
>> This is not nearly as much info as you should see.  In particular what
>> I'm actually after (the parsing debug output) is not there.
>> 
>> Can you check to see if you are sending debug output to syslog please?
>> 
>> I remember I had to alter my syslog.conf on FC2 at one point.
>> 
>> Ian

atlantos41> Strange. I do ~ automount --timeout=60 --verbose /smb file
atlantos41> /etc/auto.smb ~ cd /smb/test_data<cyrchar>est bash: cd:
atlantos41> /smb/test_data<cyrchar>est: No such file or directory ~ kill
atlantos41> -term `pidof automount`

atlantos41> My syslog.conf have lines: *.debug /var/log/messages

For debug logs, I include *everything*:

*.*	  /var/log/debug


-Jeff
