From: Michael <michael@kmaclub.com>
Subject: Re: Automounting DVD images
Date: Fri, 08 Dec 2006 13:15:48 -0700
Message-ID: <4579C7F4.4020506@kmaclub.com>
References: <457999E0.2040808@kmaclub.com>
	<1165602659.3996.59.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1165602659.3996.59.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent wrote:
> On Fri, 2006-12-08 at 09:59 -0700, Michael wrote:
>   
>> Hello,
>>
>> I have been trying to get autofs to mount DVD iso images but so far have 
>> been unsuccessful.  I want to make this work from various client 
>> machines and not on the machine that servers out the iso.
>>
>> I tried some examples from the web but can't seem to make them work.  I 
>> can mount the file by hand  over NFS without any issues.
>>
>> Here is my configuration
>>
>> NIS:
>>
>> auto.master
>> /mythtv         auto.mythtv     
>> bg,hard,intr,retry=10000,rsize=32768,wsize=32768,timeo=600,nfsvers=3,tcp
>>
>> auto.mythtv
>> iso             --timeout=60 -fstype=autofs     auto.mythtv.iso
>> video           -rw             filer:/export/services/mythtv/video
>>
>> auto.mythtv.iso
>> * -fstype=iso9660,ro,loop       /mythtv/video/Movies/&
>>     
> What happens if you use:
> * -fstype=iso9660,ro,loop       :/mythtv/video/Movies/&
>
>   

Same:

Dec  8 13:12:27 fc6 automount[12059]: mounted /mythtv/iso
Dec  8 13:12:35 fc6 automount[12059]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 13:12:35 fc6 automount[12059]: lookup_name_file_source_instance: 
file map not found
Dec  8 13:12:35 fc6 automount[12059]: failed to mount /mythtv/iso/MOVIE.iso
Dec  8 13:12:35 fc6 automount[12059]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 13:12:35 fc6 automount[12059]: lookup_name_file_source_instance: 
file map not found
Dec  8 13:12:35 fc6 automount[12059]: failed to mount /mythtv/iso/MOVIE.iso
Dec  8 13:12:35 fc6 automount[12059]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 13:12:35 fc6 automount[12059]: lookup_name_file_source_instance: 
file map not found
Dec  8 13:12:35 fc6 automount[12059]: failed to mount /mythtv/iso/MOVIE.iso

Michael
