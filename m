From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 01/10] autofs4 - use macros for active list
	handling
Date: Wed, 07 Oct 2009 11:50:59 +0800
Message-ID: <4ACC1023.4050906@themaw.net>
References: <20091001010054.7675.77673.stgit@zeus.themaw.net>
	<20091006134918.4d5dcbaf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20091006134918.4d5dcbaf.akpm@linux-foundation.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@linux.kernel.org, adilger@sun.com, linux-kernel@vger.kernel.org, hch@infradead.org, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org, sage@newdream.net, yehuda@newdream.net

Andrew Morton wrote:
> On Thu, 01 Oct 2009 09:00:55 +0800
> Ian Kent <raven@themaw.net> wrote:
> 
>> Define some simple macro functions for adding and deleting entries
>> on the active (and unhashed) dentry list.
> 
> A "macro" is that thing which we create with #define.

OK, guilty, ;)

> 
>> +static void autofs4_add_active(struct dentry *dentry)
>> +{
>> +	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
>> +	struct autofs_info *ino = autofs4_dentry_ino(dentry);
>> +	if (ino) {
>> +		spin_lock(&sbi->lookup_lock);
>> +		if (!ino->active_count) {
>> +			if (list_empty(&ino->active))
>> +				list_add(&ino->active, &sbi->active_list);
>> +		}
>> +		ino->active_count++;
>> +		spin_unlock(&sbi->lookup_lock);
>> +	}
>> +	return;
>> +}
>> +
>> +static void autofs4_del_active(struct dentry *dentry)
>> +{
>> +	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
>> +	struct autofs_info *ino = autofs4_dentry_ino(dentry);
>> +	if (ino) {
>> +		spin_lock(&sbi->lookup_lock);
>> +		ino->active_count--;
>> +		if (!ino->active_count) {
>> +			if (!list_empty(&ino->active))
>> +				list_del_init(&ino->active);
>> +		}
>> +		spin_unlock(&sbi->lookup_lock);
>> +	}
>> +	return;
>> +}
> 
> These aren't macros!  I changed the titles and changelogs of patches 1,
> 2 and 3 to use the term "helper functions".

Thanks, heaps.
Ian
