From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: stat -L triggering mount (behavior change starting with 2.6.38-rc1)
Date: Tue, 26 Mar 2013 17:41:21 -0300
Message-ID: <CAEySpB7frBeNDFAZM8+magDZqSNwf4XEQqzUK652hrak9H5tXA@mail.gmail.com>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
	<loom.20130326T135119-763@post.gmane.org>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VbDuq2yP2Kd54PSsC5Wpm+IlXRkLWznZIEpcUr8dwiE=;
        b=ycvKVTE7H2iLHMaYFeFiP/z7jVUyO4QRQUmr3MuuZgCS91fHLI2XCbbr/mc42OqaS8
         muF7a7419vUzR4eBwtzjaKjoV0+uPSNsm4LfcaQwc26RdVVE86oRM3e0IfPIc6zPIDm+
         SqtXmyOQ1wjdgt64AP+pNlxs0MI3u7RthlzZ+5Agbh4ibWVksmh7P+Rn42tiozuOg0IF
         q8pQhpv0Hl7Y9Y7LX4zZW73iPuHQiYiF4z/tPFl5/2kzIfRRZ2NCKg7xKMzpwSgmqZYI
         kf8RHTkY5P5bUYmboIHBzFrq7vUq0jPyCMQcD+IUYZdQdPMO3QlyGvWea+wvR5zqKgQn
         fcqA==
In-Reply-To: <loom.20130326T135119-763@post.gmane.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: toto <guillaume@apostoly.com>
Cc: autofs@vger.kernel.org

On Tue, Mar 26, 2013 at 9:56 AM, toto <guillaume@apostoly.com> wrote:
> Leonardo Chiquitto <leonardo.lists <at> gmail.com> writes:
>
>>
>> Hello,
>>
>> After the update to 2.6.38, I noticed that AutoFS started to mount volumes
>> at times it normally wouldn't. More specifically, "ls -la" inside an AutoFS
>> mount point will trigger the mount of all available maps.
> __________
>> autofs mailing list
>> autofs <at> linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>>
>
> Hi,

Hi,

> When you are saying that "ls -la" should not trigger
>  the automounting of the volumes inside the directory,
> what would be then the good command line to
> trigger the mounting of volumes declared in auto.master ?

The problem that was discussed in this thread was about
accesses to a parent directory triggering mounts of volumes
in sub-directories. An example:

/nfs/volume1
/nfs/volume2

Here volume1 and volume2 are two automounted directories.
What was happening is that "ls -la /nfs" was triggering the
mounts of volume1 and volume2.

> I am using Mac OS X 10.8.3 and by default,
> the elements defined in automaster are mounted when
> accessed by an application (like the Finder,
>  which is if you don't know the file manager of OS X), but how
> then to trigger the silent mounting at startup
> with a shell script ?

You just need to access the volume. Using the example above,
any of these should work:

$ stat /nfs/volume1/    #  the slash at the end is important
$ cd /nfs/volume1
$ ls /nfs/volume1

> Are there parameters to pass to "mount"
> command to say "mount this folder
> NOW as defined in auto master" ?

No, not that I'm aware.

Thanks,
Leonardo
